class Create<%= block_migration_name %> < <%= migration_class_name %>
  def up
    create_table :<%= block_name_plural %> do |t|
      t.references :parent, polymorphic: true
      t.integer :position
<% attributes.each do |attribute| -%>
      t.<%= attribute.type %> :<%= attribute.name %>
<% end -%>
      t.timestamps
    end
  end

  def down
    drop_table :<%= block_name_plural %>
  end
end
