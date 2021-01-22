meta:
  id: amx
  file-extension: amx
  endian: le
seq:
  - id: header
    type: header
  - id: table_init
    type: table_init
  - id: table_ofs
    type: table_ofs
instances:
  public:
    pos: table_ofs.ofs_public
    type: table
  native:
    pos: table_ofs.ofs_native
    type: table
  libraries:
    pos: table_ofs.ofs_libraries
    type: table
  public_vars:
    pos: table_ofs.ofs_public_vars
    type: table
  public_tags:
    pos: table_ofs.ofs_public_tags
    type: table
  nametable:
    pos: table_ofs.ofs_nametable
    type: table
  overlays:
    pos: table_ofs.ofs_overlays
    type: table
types:
  header:
    seq:
      - id: len_file
        type: u4
      - id: magic
        size: 2
      - id: version
        size: 2
      - id: flags
        type: u2
      - id: len_definition
        type: u2
  table_init:
    seq:
      - id: init_code
        type: u4
      - id: init_data
        type: u4
      - id: init_heap
        type: u4
      - id: init_stack
        type: u4
      - id: init_instruction
        type: u4
  table_ofs:
    seq:
      - id: ofs_public
        type: u4
      - id: ofs_native
        type: u4
      - id: ofs_libraries
        type: u4
      - id: ofs_public_vars
        type: u4
      - id: ofs_public_tags
        type: u4
      - id: ofs_nametable
        type: u4
      - id: ofs_overlays
        type: u4
  table:
    seq:
      - id: cell
        type: cell
        repeat: expr
        repeat-expr: 3
    types:
      cell:
        seq:
          - id: ofs
            type: u4
          - id: ofs_name
            type: u4
        instances:
          name:
            pos: ofs_name
            type: strz
            encoding: UTF-8