package meman;

import meman.IObj;

interface IMeman {
    function add(obj:IObj) : IObj;
    function remove(obj:IObj) : IObj;
    function get(objectId:Int) : IObj;
    function initialize(obj:IObj) : IObj;
    function changeAttribute(inst:IObj, oldVal:IObj, newVal:IObj) : IObj;
}
