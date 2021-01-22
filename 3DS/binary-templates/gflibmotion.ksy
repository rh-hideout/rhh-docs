meta:
  id: gfl_motion_anim
  file-extension: mbin
  endian: le
seq:
  - id: type
    type: u4
  - id: count_sections
    type: u4
  - id: entries
    type: anim_entry
    repeat: expr
    repeat-expr: count_sections
enums:
  entry_type:
    0: anim_info
    1: anim_skeleton
    3: anim_material
    5: anim_unknown5
    6: anim_visibility
    7: anim_event

types:
  anim_entry:
    seq:
      - id: type_entry
        enum: entry_type
        type: u4
      - id: len_entry
        type: u4
      - id: ofs_entry
        type: u4
    instances:
      animation:
        pos: ofs_entry
        size: len_entry
        type:
          switch-on: type_entry
          cases:
            'entry_type::anim_info': anim_info
            'entry_type::anim_skeleton': anim_skeleton
            'entry_type::anim_unknown5': anim_unknown5
            'entry_type::anim_material': anim_material
            'entry_type::anim_visibility': anim_visibility
            'entry_type::anim_event': anim_event

  anim_info:
    seq:
      - id: count_frame
        type: u4
      - id: is_loop
        type: u2
      - id: is_smooth
        type: u2
      - id: min_something
        type: vec3
      - id: max_something
        type: vec3
      - id: anim_hash
        type: u4

  anim_skeleton:
    seq:
      - id: count_bones
        type: u4
      - id: ofs_bone_data
        type: u4
      - id: str_bones
        type: anim_str
        repeat: expr
        repeat-expr: count_bones
      - id: padding
        size: 3 - (_io.pos - 1) % 4
      - id: skeleton_track
        type: track_bone
        repeat: expr
        repeat-expr: count_bones

  anim_unknown5:
    seq:
      - id: count_unk0
        type: u4
      - id: ofs_unk_data
        type: u4
      - id: units
        type: u4
        repeat: expr
        repeat-expr: count_unk0
      - id: str_unk
        type: anim_str
        repeat: expr
        repeat-expr: count_unk0
      - id: padding
        size: 3 - (_io.pos - 1) % 4
      - id: unknown_track
        size-eos: true

  anim_material:
    seq:
      - id: count_material
        type: u4
      - id: ofs_material_data
        type: u4
      - id: units
        type: u4
        repeat: expr
        repeat-expr: count_material
      - id: names
        type: anim_str
        repeat: expr
        repeat-expr: count_material
      - id: padding
        size: 3 - (_io.pos - 1) % 4
      - id: material_track
        type: track_material
        repeat: expr
        repeat-expr: count_material

  anim_visibility:
    seq:
      - id: count_meshes
        type: u4
      - id: ofs_visibility_data
        type: u4
      - id: str_meshes
        type: anim_str
        repeat: expr
        repeat-expr: count_meshes
      - id: padding
        size: 3 - (_io.pos - 1) % 4
      - id: visibility_track
        size-eos: true

  anim_event:
    seq:
      - id: count_events
        type: u4
      - id: events
        type: track_event
        repeat: expr
        repeat-expr: count_events
  
  track_event:
    seq:
      - id: name
        type: strz
        encoding: UTF-8
      - id: padding
        size: 3 - (_io.pos - 1) % 4
      - id: count
        type: u4
      - id: keys
        type: u4
      - id: values
        type: f4
  
  anim_str:
    seq:
      - id: len_str
        type: u1
      - id: str
        type: str
        encoding: UTF-8
        size: len_str

  vec3:
    seq:
      - id: x
        type: f4
      - id: y
        type: f4
      - id: z
        type: f4

  track_bone:
    seq:
      - id: flags
        type: u4
      - id: len_frame
        type: u4
      - id: data
        size: len_frame

  channel_bone:
    seq:
      - id: count
        type: u4
      - id: keys
        type: u1
        repeat: expr
        repeat-expr: count
      - id: values
        type: f4
        repeat: expr
        repeat-expr: count

  track_material:
    seq:
      - id: idx_unit
        type: u4
      - id: flags
        type: u4
      - id: len_frame
        type: u4
      - id: data
        size: len_frame
 
  frame_visibility:
    seq:
      - id: vis
        type: u1
