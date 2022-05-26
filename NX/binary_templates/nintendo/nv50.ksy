meta:
  id: nv50
  file-extension: nv
  endian: le
  bit-endian: le
seq:
  - id: magic
    type: u4
  - id: padding
    size: 0x2C
  - id: prog
    type: prog
  - id: code
    size-eos: true
types:
  prog:
    seq:
      - id: common_word_0
        type: common0
      - id: common_word_1
        type: u4
      - id: common_word_2
        type: u4
      - id: common_word_3
        type: u4
      - id: common_word_4
        type: u4
      - id: data
        type:
          switch-on: common_word_0.sph_type
          cases:
            0x1: vtg
            0x2: ps
  vtg:
    seq:
      - id: imap_sys_val_a
        size: 3
      - id: imap_sys_val_b
        type: imap_sys_values_b
      - id: imap_gen_vector
        type: imap_generic_vector
        repeat: expr
        repeat-expr: 32
      - id: imap_color
        size: 2
      - id: imap_sys_vals_c
        size: 2
      - id: imap_fixed_fn_tex
        size: 5
      - id: imap_reserved
        size: 1
      - id: omap_sys_vals_a
        size: 3
      - id: omap_sys_vals_b
        type: omap_sys_values_b
      - id: omap_gen_vector
        type: omap_generic_vector
        repeat: expr
        repeat-expr: 32
      - id: omap_color
        size: 2
      - id: omap_sys_vals_c
        size: 2
      - id: omap_fixed_fn_tex
        size: 5
      - id: omap_reserved
        size: 1
  ps:
    seq:
      - id: imap_sys_val_a
        size: 3
      - id: imap_sys_val_b
        type: imap_sys_values_b
      - id: imap_gen_vector
        type: imap_pixel_vector
        repeat: expr
        repeat-expr: 32
      - id: imap_color
        size: 2
      - id: imap_sys_val_c
        size: 2
      - id: imap_fixed_fn_tex
        size: 10
      - id: imap_reserved
        size: 2
      - id: omap_target
        type: omap_target
        repeat: expr
        repeat-expr: 8
      - id: omap_bools
        size: 4
        
  common0:
    seq:
      - id: sph_type
        type: b5
      - id: version
        type: b5
      - id: sh_type
        type: b4
      - id: mrt_enable
        type: b1
      - id: kills_pixels
        type: b1
      - id: does_global_store
        type: b1
      - id: sass_version
        type: b4
      - id: reserved
        type: b3
      - id: geometry_passthrough
        type: b1
      - id: unknown_flag
        type: b1
      - id: does_load_or_store
        type: b1
      - id: does_fp64
        type: b1
      - id: stream_out_mask
        type: b4
  #Common 1, 2, 3 and 4 are
  #Pretty much unused for vertex
  #And pixel shaders...

  #SysValuesA only has tessellation info
  #Which is also not used in vertex
  #and pixel shaders...

  imap_sys_values_b:
    seq:
      - id: primitive_id
        type: b1
      - id: rt_array_index
        type: b1
      - id: viewport_index
        type: b1
      - id: point_size
        type: b1
      - id: pos_x
        type: b1
      - id: pos_y
        type: b1
      - id: pos_z
        type: b1
      - id: pos_w
        type: b1

  imap_generic_vector:
    seq:
      - id: x
        type: b1
      - id: y
        type: b1
      - id: z
        type: b1
      - id: w
        type: b1

  imap_pixel_vector:
    seq:
      - id: x
        type: b2
      - id: y
        type: b2
      - id: z
        type: b2
      - id: w
        type: b2

  omap_sys_values_b:
    seq:
      - id: primitive_id
        type: b1
      - id: rt_array_index
        type: b1
      - id: viewport_index
        type: b1
      - id: point_size
        type: b1
      - id: pos_x
        type: b1
      - id: pos_y
        type: b1
      - id: pos_z
        type: b1
      - id: pos_w
        type: b1

  omap_generic_vector:
    seq:
      - id: x
        type: b1
      - id: y
        type: b1
      - id: z
        type: b1
      - id: w
        type: b1

  omap_target:
    seq:
      - id: r
        type: b1
      - id: g
        type: b1
      - id: b
        type: b1
      - id: a
        type: b1

