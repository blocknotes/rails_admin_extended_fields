# rails_admin_extended_fields

A [rails_admin](https://github.com/sferik/rails_admin) plugin to add more options to fields.

Features:

- nested sortable tabs

- load fields css classes from model

## Install

- Add to the Gemfile:

`gem 'rails_admin_extended_fields'`

- Edit or create *app/assets/javascripts/rails_admin/custom/ui.js* and add:

`//= require rails_admin_extended_fields`

## Usage

#### nested sortable tabs

Example with a parent model *Page* and a nested model *Block*

- Add a position field to your nested model (ex. an integer or float column):

`rails generate migration AddPositionToBlocks position:float`

- Optionally add a default in the migration (ex. `add_column :blocks, :position, :float, null: false, default: 0.0`)

- Add a default ordered scope to the nested model:

`default_scope { order( position: :desc ) }`

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

#### load fields css classes from model

It can be useful to add specific classes to some fields using Single Table Inheritance models.

- Add to a model:

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

- Class 'hide' is added to *abstract* and *name* fields of *BlockImage* only

## Contributors

- [Mattia Roccoberton](http://blocknot.es) - creator, maintainer
