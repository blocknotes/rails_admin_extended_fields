# rails_admin_extended_fields [![Gem Version](https://badge.fury.io/rb/rails_admin_extended_fields.svg)](https://badge.fury.io/rb/rails_admin_extended_fields)

A [rails_admin](https://github.com/sferik/rails_admin) plugin to add more options to fields.

Features:

- load fields css classes from models

- nested sortable tabs (with drag and drop)

- *nested_list*: has_many associations alternative views (list and accordion)

- *nested_one*: has_one associations alternative view

Notes:

- *nested_list* and *nested_one* don't support creating new records and deleting existing ones

## Install

- Add to the Gemfile:

`gem 'rails_admin_extended_fields'`

- Edit or create *app/assets/javascripts/rails_admin/custom/ui.js* and add:

`//= require rails_admin_extended_fields`

## Usage

#### load fields css classes from model

It can be useful to add specific classes to some fields using Single Table Inheritance models:

```ruby
class Block < ApplicationRecord
  def type_enum
    @type_enum ||= [ 'BlockImage', 'BlockText' ]
  end
end

class BlockImage < Block
  def css_class
    @css_class ||= {
      abstract: 'hide',
      name: 'hide'
    }
  end
end
```

Class 'hide' is added to *abstract* and *name* fields of *BlockImage* only.

#### nested sortable tabs

Example: a parent model *Page* and a nested model *Block* (page has many blocks)

- Add a position field to your nested model (ex. an integer or float column):

`rails generate migration AddPositionToBlocks position:float`

- Optionally add a default in the migration (ex. `add_column :blocks, :position, :float, null: false, default: 0.0`)

- Add a default ordered scope to the nested model:

`default_scope { order( :position ) }`

- rails_admin config:

```ruby
  config.model Block do
    nested do
      field :position, :hidden do
        html_attributes 'data-sortable': 'true'
      end
    end
  end

  config.model Page do
    edit do
      field :blocks do
        css_class 'nested-sortable'
      end
    end
  end
```

- If you edit a *Page* in rails_admin *Blocks* should be draggable

- If you want to add a symbol to draggable handlers you can add a CSS rule like: `.ui-sortable-handle > a::before { content: '\2194  '; }`

#### nested_list

- Present an has_many association as a list:

`field :page_options, :nested_list`

- Present an has_many association as an accordion with drag and drop reordering:

```ruby
  field :page_options, :nested_list do
    accordion true
    sortable true
  end
```

#### nested_one

- Present an has_one association:

`field :page_info, :nested_one`

## Contributors

- [Mattia Roccoberton](http://blocknot.es) - creator, maintainer
