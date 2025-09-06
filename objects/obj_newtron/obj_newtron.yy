{
  "resourceType": "GMObject",
  "resourceVersion": "1.0",
  "name": "obj_newtron",
  "spriteId": {
    "name": "spr_newtron_editor",
    "path": "sprites/spr_newtron_editor/spr_newtron_editor.yy",
  },
  "solid": false,
  "visible": false,
  "managed": true,
  "spriteMaskId": {
    "name": "spr_newtron_fire_blue",
    "path": "sprites/spr_newtron_fire_blue/spr_newtron_fire_blue.yy",
  },
  "persistent": false,
  "parentObjectId": {
    "name": "obj_object_enemy",
    "path": "objects/obj_object_enemy/obj_object_enemy.yy",
  },
  "physicsObject": false,
  "physicsSensor": false,
  "physicsShape": 1,
  "physicsGroup": 1,
  "physicsDensity": 0.5,
  "physicsRestitution": 0.1,
  "physicsLinearDamping": 0.1,
  "physicsAngularDamping": 0.1,
  "physicsFriction": 0.2,
  "physicsStartAwake": true,
  "physicsKinematic": false,
  "physicsShapePoints": [],
  "eventList": [
    {"resourceType":"GMEvent","resourceVersion":"1.0","name":"","isDnD":false,"eventNum":0,"eventType":0,"collisionObjectId":null,},
    {"resourceType":"GMEvent","resourceVersion":"1.0","name":"","isDnD":false,"eventNum":0,"eventType":3,"collisionObjectId":null,},
  ],
  "properties": [
    {"resourceType":"GMObjectProperty","resourceVersion":"1.0","name":"iv_type","varType":6,"value":"NEWTRON_TYPE.FALL","rangeEnabled":false,"rangeMin":0.0,"rangeMax":10.0,"listItems":[
        "NEWTRON_TYPE.FALL",
        "NEWTRON_TYPE.FIRE",
      ],"multiselect":false,"filters":[],},
  ],
  "overriddenProperties": [],
  "parent": {
    "name": "Badniks",
    "path": "folders/Objects/Badniks.yy",
  },
}