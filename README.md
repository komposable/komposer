## Komposer

### Installation

```ruby
gem 'komposer'
```

In order to use **Komposer** in your administration panel, you need to
require some dependencies.

```js
// app/assets/javascripts/administration.js

//= require komposer
```

```css
// app/assets/stylesheets/administration.scss

@import 'komposer';
```

### Block

#### Usage

Generate new block with:

```sh
rails generate komposer:block title_block title:string
```

The previous command generates:
- `frontend/components/title_blocks/_block_form.html.slim`
- `frontend/components/title_blocks/_title_block.html.slim`
- `frontend/components/title_blocks/title_block.js`
- `frontend/components/title_blocks/title_block.css`
- append to `frontend/components/index.js`

A block is very similar to `component`, but they have a form representation
to be administrable.

To administrate the block since a back-office, you need to declare
presence of blocks in model.

```rb
# app/models/article.rb

class Article < ApplicationRecord
  has_blocks([:title_blocks])
end
```

```slim
# app/views/articles/_form.html.slim

= bootstrap_form_for @article do |f|
  = f.blocks_form
```

Now in your frontend pages, you can just render blocks like normal Rails partials.

```slim
= render @article.blocks
```
