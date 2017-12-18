$(document).on("click", ".block-button", function(e) {
  e.preventDefault();

  var $button = $(this);
  var $buttonWrapper = $button.closest(".block-form");
  var $blockForms = $button.closest(".ouvrages-blocks").find(".block-forms");
  var buttonsHTML = $blockForms.data("buttons").html;

  var $newBlock = generateBlockForm($button, buttonsHTML);

  $(this).closest(".collapse").collapse('hide');

  if ($buttonWrapper.length === 0) {
    $blockForms.append($newBlock);
  } else {
    $newBlock.insertBefore($buttonWrapper);
  }

  updateBlockFormPositions();
  $(document).trigger("blocks:add", $newBlock);
});

generateBlockForm = function(button, buttonsHTML) {
  var $button = $(button);
  var formData = $button.data("form").html;
  var blocksCount = $(".block-form").length;

  formData = formData.replace(/\[__.+?__\]/g, "[" + blocksCount + "]");
  formData = formData.replace(/___NEW__.+?___/g, "_" + blocksCount + "_");

  buttonsHTML = buttonsHTML.replace(/__ID__/g, "_" + blocksCount + "_");

  return $("<div class='block-form'><div class='block-buttons'>" + buttonsHTML + "</div><div class='panel panel-primary'>" + formData + "</div>");
};

updateBlockFormPositions = function() {
  $(".block-form").each(function(index, form) {
    var $form = $(form);
    $form.find(".block-position").val(index);
  });
};

createSortable = function() {
  $(".block-forms").sortable({
    group: {
      name: "forms",
      pull: true,
      put: true,
    },
    sort: true,
    handle: ".handler",
    draggable: ".block-form",
    ghostClass: "sortable-ghost",
    animation: 150,
    onUpdate: function(event) {
      updateBlockFormPositions();
      $(document).trigger("blocks:move", event.item);
    },
    onAdd: function(event) {
      $newBlock = generateBlockForm(event.clone);
      $(event.item).replaceWith($newBlock);
      $(document).trigger("blocks:add", $newBlock);
      updateBlockFormPositions();
    }
  });
};

$.fn.initRichTextareas = function() {
  this.find(".rich-textarea").each(function() {
    var $textarea = $(this);
    var config = $textarea.data("tinymce-config");
    var options = eval("(" + config + ")");
    options.target = $textarea[0];
    delete options.selector;
    tinyMCE.init(options);
  });
  return this;
};

$(document).on("blocks:add", function(e, block) {
  $(block).initRichTextareas();
  $(block).find(".address_picker").each(function(index, element) {
    $(element).addressPickerField();
  });
  createSortable();
});

$(document).on("blocks:move", function(e, block) {
  $(block).find(".rich-textarea").each(function() {
    var $element = $(this);
    tinyMCE.EditorManager.execCommand("mceRemoveEditor", false, $element.attr("id"));
  });
  $(block).initRichTextareas();
});

$(document).on('turbolinks:before-cache', function() {
  $(".address_picker").each(function(index, element) {
    $(this).find(".address").typeahead("destroy");
  });
  tinyMCE.remove();
});

$(document).on('turbolinks:load', function() {
  $(document.body).initRichTextareas();
  createSortable();
});

$(document).on("click", ".remove-block-form-button", function(e) {
  e.preventDefault();
  $blockForm = $(this).closest(".block-form");

  if ($blockForm.hasClass("block-deleted")) {
    $blockForm.removeClass("block-deleted");
    $blockForm.find(".block-destroy").val(false);
  } else {
    $blockForm.addClass("block-deleted");
    $blockForm.find(".block-destroy").val(true);
  }
});

$(document).on("click", ".collapse-block-form-button", function(e) {
  e.preventDefault();
  $blockFormBody = $(this).closest(".block-form").find(".panel-body");
  $blockFormIcon = $(this).closest(".block-form").find(".collapse-block-form-button");

  open = $blockFormBody.hasClass('in');
  $blockFormBody.collapse('toggle');

  if (open) {
    $blockFormIcon.removeClass('glyphicon-minus');
    $blockFormIcon.addClass('glyphicon-plus');
  } else {
    $blockFormIcon.removeClass('glyphicon-plus');
    $blockFormIcon.addClass('glyphicon-minus');
  }
});

$(document).on("show.bs.collapse", ".block-buttons", function(e) {
  $(e.currentTarget).find(".blocks-toggle i").removeClass("glyphicon-plus").addClass("glyphicon-chevron-up");
});

$(document).on("hide.bs.collapse", ".block-buttons", function(e) {
  $(e.currentTarget).find(".blocks-toggle i").removeClass("glyphicon-chevron-up").addClass("glyphicon-plus");
});
