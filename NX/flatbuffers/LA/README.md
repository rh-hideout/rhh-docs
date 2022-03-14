# Pokémon Legends Arceus (Hayabusa)
Still using flatbuffers!

## Progress
`gfl::mdl2`
- [x] TRMDL - Model
- [x] TRMSH - Mesh
- [x] TRMTR - Material
- [x] TRMBF - MeshBuffer
- [x] TRSKL - Skeleton
- [x] TRPOKECFG - Pokemon Config (Inframe related)

`gfl::anm2`
- [x] TRANM - Animation
- [x] TRAEF - Animation Effects
- [x] TRCMA - Camera Animation
- [x] TRACN - Animation Channel Names
- [x] TRACL - Animation Channel Layer
- [x] TRACS - Animation Channel State
- [x] TRACP - Animation Channel Parameter
- [x] TRSPB - Animation Spring Bone
- [x] TRBIK - Animation Biped IK
- [x] TRALK - Animation LookAt
    - Very Incomplete
    - Defines how trainers procedurally look at you when nearby

`field`
- [x] TRTRR - Terrain Resource
    - Also references TRMBF and TRMTR for Splatmap/Geometry Buffer 
- [x] TRINS - Terrain Instance
    - Requires parsing after conversion...
- [ ] TRHF - Terrain HeightField
- [ ] TRCOL - Terrain Collision

`gfx2`
- [x] TRLGT - Light
- [x] TRSHA - Shader Slot Configuration
- [x] TRTCH - Shader Technique (?)

`npc`
- [x] TRBSM - Bone, Scaler, Meshes? 
    - Related to CC folder, need to investigate more

`pml`
- [ ] Personal Data
- [ ] TRLOC
- [ ] TRPMCATALOG

`unk`
- [ ] TRFMD
- [ ] TRPFD

