meta:
  id: amx
  file-extension: amx
  endian: le
seq:
  - id: header
    type: header

types:
  header:
    seq:
    - id: size
      type: u4
    - id: magic
      type: u2
    - id: file_version
      type: u1
    - id: amx_version
      type: u1
    - id: flags
      type: u2
    - id: defsize
      type: u2
    - id: cod
      type: u4
    - id: dat
      type: u4
    - id: hea
      type: u4
    - id: stp
      type: u4
    - id: cip
      type: u4
    - id: publics
      type: u4
    - id: natives
      type: u4
    - id: libraries
      type: u4
    - id: pubvars
      type: u4
    - id: tags
      type: u4
    - id: nametable
      type: u4
    - id: overlays
      type: u4
 
    instances:
      tbl_publics:
        io: _root._io
        pos: publics
        size: natives - publics
        type: func_table
        if: size != 0
      tbl_natives:
        io: _root._io
        pos: natives
        size: libraries - natives
        type: func_table
        if: size != 0
      tbl_libraries:
        io: _root._io
        pos: libraries
        size: pubvars - libraries
        type: func_table
        if: size!= 0
      tbl_pubvars:
        io: _root._io
        pos: pubvars
        size: tags - pubvars
        type: func_table
        if: size!= 0
      tbl_tags:
        io: _root._io
        pos: tags
        size: overlays - tags
        type: func_table
        if: size!= 0
      tbl_overlays:
        io: _root._io
        pos: overlays
        size: nametable - overlays
        type: ovl_table
        if: size!= 0
      tbl_nametable:
        io: _root._io
        pos: nametable
        type: u4

  ovl_table:
    seq:
      - id: ovl_stub
        type: ovl_stub
        size: 0xC
        repeat: eos

  ovl_stub:
    seq:
      - id: offset
        type: u8
      - id: size
        type: u4

  func_table:
    seq:
      - id: func_stub
        type: func_stub
        size: 0xC
        repeat: eos

  func_stub:
    seq:
      - id: address
        type: u8
      - id: nameofs
        type: u4

  function:
    seq:
      - id: base
        type: u8
      - id: code
        type: u8
      - id: data
        type: u8
      - id: callback
        type: u8
      - id: debug
        type: u8
      - id: overlay
        type: u8
      - id: cip
        type: u8
      - id: frm
        type: u8
      - id: hea
        type: u8
      - id: hlw
        type: u8
      - id: stk
        type: u8
      - id: stp
        type: u8
      - id: flags
        type: u4
      - id: usertags
        type: u4
        repeat: expr
        repeat-expr: 5
      - id: userdata
        type: u8
        repeat: expr
        repeat-expr: 5
      - id: error
        type: u4
      - id: paramcount
        type: u4
      - id: pri
        type: u8
      - id: alt
        type: u8
      - id: reset_stk
        type: u8
      - id: reset_hea
        type: u8
      - id: sysreq_d
        type: u8
      - id: ovl_index
        type: u4
      - id: codesize
        type: u4
