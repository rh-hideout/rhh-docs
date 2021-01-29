meta:
  id: toc
  file-extension: toc
  endian: be

seq:
  - id: magic
    contents: 'GLLA'
  - id: version
    size: 4
  - id: entry_count
    type: u4
  - id: reserved
    type: u4
  - id: data_pos
    type: u4
  - id: header_size
    type: u4
  - id: unk4
    type: u4
  - id: unk5
    type: u4

instances:
  entry:
    pos: data_pos
    type: data
    size: 16
    repeat: expr
    repeat-expr: entry_count

types:
  data:
    seq:
      - id: index
        type: u4
      - id: name_pos
        type: u4
    instances:
      name:
        io: _root._io
        pos: name_pos
        type: strz
        encoding: ASCII

