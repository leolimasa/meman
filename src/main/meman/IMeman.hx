package meman;

import meman.IManaged;

interface IMeman {
    function add(obj:IManaged) : IManaged;
    function remove(obj:IManaged) : IManaged;
    function get(objectId:Int) : IManaged;
}
