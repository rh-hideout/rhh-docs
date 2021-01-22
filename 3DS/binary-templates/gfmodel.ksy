meta:
  id: gfmodel
  file-extension: gfmodel
  endian: le
seq:
  - id: pack_header
    type: pack_header
  - id: header
    type: gfmodel_header
  - id: shader_hashtable
    type: gfmodel_hashtable
  - id: texture_hashtable
    type: gfmodel_hashtable
  - id: material_hashtable
    type: gfmodel_hashtable
  - id: mesh_hashtable
    type: gfmodel_hashtable
  - id: min_box
    type: bounding_box
  - id: max_box
    type: bounding_box
  - id: transform_matrix
    type: transform_matrix
  - id: unknown_struct
    type: gfmodel_unkstruct
  - id: skeleton
    type: gfmodel_skeleton
  - id: textures
    type: gfmodel_textures
  - id: materials
    type: gfmodel_material
    repeat: expr
    repeat-expr: material_hashtable.count_hashes
  - id: meshes
    type: gfmodel_mesh
    repeat: expr
    repeat-expr: mesh_hashtable.count_hashes
types:
  pack_header:
    seq:
      - id: sec_magic
        size: 4
      - id: sec_index
        type: u4
      - id: sec_unk1
        type: u4
      - id: sec_unk2
        type: u4
  gfmodel_header:
    seq:
      - id: model_magic
        type: strz
        encoding: UTF-8
      - id: model_version
        size: 4
      - id: padding
        size: 7 - (_io.pos - 1) % 8
  gfmodel_hashtable:
    seq:
      - id: count_hashes
        type: u4
      - id: hashes
        type: hash_entry
        repeat: expr
        repeat-expr: count_hashes
    types:
      hash_entry:
        seq:
          - id: hash
            type: u4
          - id: name
            type: str
            encoding: UTF-8
            size: 64
  gfmodel_unkstruct:
    seq:
      - id: unk1
        type: u4
      - id: unk2
        type: u4
      - id: unk3
        type: u8
      - id: unk4
        size: unk2
  gfmodel_skeleton:
    seq:
      - id: count
        type: u4
      - id: reserved
        type: u4
        repeat: expr
        repeat-expr: 3
      - id: skeleton
        type: skel_bone
        repeat: expr
        repeat-expr: count
      - id: padding
        size: 7 - (_io.pos - 1) % 8
    types:
      skel_bone:
        seq:
          - id: name
            type: byte_string
          - id: parent_name
            type: byte_string
          - id: flags
            type: b1
            repeat: expr
            repeat-expr: 8
          - id: vec_scale
            type: skel_vec
          - id: vec_rot
            type: skel_vec
          - id: vec_translate
            type: skel_vec
      skel_vec:
        seq:
          - id: x
            type: f4
          - id: y
            type: f4
          - id: z
            type: f4
  gfmodel_textures:
    seq:
      - id: count
        type: u4
      - id: length
        type: u4
      - id: padding
        size: 1 + (_io.pos - 1) % 16
      - id: textures
        type: texture
        size: length + 16
        repeat: expr
        repeat-expr: count
    types:
      texture:
        seq:
          - id: hash
            size: 16
          - id: unk
            size-eos: true
  gfmodel_material:
    seq:
      - id: magic
        contents: 'material'
      - id: material_size
        type: u4
      - id: padding
        size: 7 - (_io.pos - 1) % 8
      - id: material
        type: material
        size: material_size
    types:
      material:
        seq:
          - id: material_name
            type: hash_name
          - id: shader_name
            type: hash_name
          - id: vertex_name
            type: hash_name
          - id: fragment_name
            type: hash_name
          - id: lut_hashes
            type: u4
            repeat: expr
            repeat-expr: 4
          - id: constants
            type: u1
            repeat: expr
            repeat-expr: 8
          - id: colors
            type: u4
            repeat: expr
            repeat-expr: 12
          - id: edge_type
            type: u4
          - id: edge_enable
            type: u4
          - id: edge_id
            type: u4
          - id: projection_type
            type: u4
          - id: rim_power
            type: f4
          - id: rim_scale
            type: f4
          - id: phong_power
            type: f4
          - id: phong_scale
            type: f4
          - id: edge_offset_enable
            type: u4
          - id: edge_alpha_mask
            type: u4
          - id: bake_textures
            type: u4
            repeat: expr
            repeat-expr: 3
          - id: bake_constants
            type: u4
            repeat: expr
            repeat-expr: 6
          - id: vertex_shader_type
            type: u4
          - id: shader_constants
            type: f4
            repeat: expr
            repeat-expr: 4
          - id: texture_coord_count
            type: u4
          - id: texture_coords
            type: texture_coord
            repeat: expr
            repeat-expr: texture_coord_count
          - id: padding
            size: 15 - (_io.pos - 1) % 16
          - id: command_buf_length
            type: u4
          - id: render_priority
            type: u4
          - id: unk0
            type: u4
          - id: render_layer
            type: u4
          - id: unk1
            type: u4
          - id: unk2
            type: u4
          - id: unk3
            type: u4
          - id: unk4
            type: u4
          - id: commands
            size: command_buf_length
          - id: reserved
            size-eos: true
      texture_coord:
        seq:
          - id: name
            type: hash_name
          - id: index
            type: u1
          - id: mapping
            type: u1
          - id: scale
            type: vector_2
          - id: rotation
            type: f4
          - id: translate
            type: vector_2
          - id: wrap_u
            type: u4
          - id: wrap_v
            type: u4
          - id: mag_filter
            type: u4
          - id: min_filter
            type: u4
          - id: min_lod
            type: u4
      vector_2:
        seq:
          - id: x
            type: f4
          - id: y
            type: f4
  gfmodel_mesh:
    seq:
      - id: magic
        size: 8
      - id: length
        type: u4
      - id: padding
        size: 15 - (_io.pos - 1) % 16
      - id: mesh
        type: mesh
        size: length
    types:
      mesh:
        seq:
          - id: name
            type: hash_entry
          - id: padding
            type: u4
          - id: min_box
            type: bounding_box
          - id: max_box
            type: bounding_box
          - id: mesh_count
            type: u4
          - id: weight_count
            type: u4
          - id: reserved
            size-eos: true
      hash_entry:
        seq:
          - id: hash
            type: u4
          - id: name
            type: str
            encoding: UTF-8
            size: 64
  hash_name:
    seq:
      - id: hash
        type: u4
      - id: name
        type: byte_string
  byte_string:
    seq:
      - id: length
        type: u1
      - id: name
        type: str
        encoding: UTF-8
        size: length
  bounding_box:
    seq:
      - id: x
        type: f4
      - id: y
        type: f4
      - id: width
        type: f4
      - id: height
        type: f4
  transform_matrix:
    seq:
      - id: x
        type: f4
        repeat: expr
        repeat-expr: 4
      - id: y
        type: f4
        repeat: expr
        repeat-expr: 4
      - id: z
        type: f4
        repeat: expr
        repeat-expr: 4
      - id: w
        type: f4
        repeat: expr
        repeat-expr: 4
