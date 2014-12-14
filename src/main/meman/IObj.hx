package meman;
interface IObj {
    function get_objectId() : Int;
    function set_objectId(id : Int) : Int;
    function get_refCount() : Int;
    function set_refCount(count : Int) : Int;
}
