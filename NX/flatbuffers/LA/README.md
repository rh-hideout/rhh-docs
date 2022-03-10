# Pokémon Legends Arceus (Hayabusa)
Still using flatbuffers!

## Progress
`gfl::mdl2`
- [x] TRMDL - Model
- [x] TRMSH - Mesh
- [x] TRMTR - Material
- [x] TRMBF - MeshBuffer
- [x] TRSKL - Skeleton
- [ ] TRPOKECFG - Pokemon Config (Inframe related)

`gfl::anm2`
- [x] TRACN - Animation Channel Names
- [x] TRACL - Animation Channel Layer
- [ ] TRACS - Animation Channel State
- [x] TRACP - Animation Channel Parameter
- [ ] TRSPB - Animation Spring Bone
- [ ] TRBIK - Animation Biped IK
- [ ] TRALK - Animation LookAt, 
    - Very Incomplete
    - Defines how trainers procedurally look at you when nearby

`field`
- [x] TRTRR - Terrain Resource
    - Also references TRMBF and TRMTR for Splatmap/Geometry Buffer 
- [x] TRINS - Terrain Instance
- [ ] TRHF - Terrain HeightField
- [ ] TRCOL - Terrain Collision

`gfx2`
- [x] TRLGT - Light

`pml`
- [ ] Personal Data
- [ ] trloc
- [ ] trpmcatalog

`unk`
- [ ] trfmd
- [ ] trpfd
