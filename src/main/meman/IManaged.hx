package meman;
interface IManaged {
    function getObjectId() : Int;
    function setObjectId(id : Int) : Int;
    function getRefCount() : Int;
    function setRefCount(count : Int) : Int;
}
