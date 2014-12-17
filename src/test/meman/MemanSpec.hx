package meman;

import meman.mock.MockObj;
import buddy.Should;
import mockatoo.Mockatoo;
import meman.IObj;
import meman.Meman;
import meman.IMeman;
import buddy.BuddySuite;

import mockatoo.Mockatoo.*;
using mockatoo.Mockatoo;
using buddy.Should;

class MemanSpec extends BuddySuite {
    public function new() {
        describe('Memory manager', function() {
            var meman : IMeman = null;
            var managedObj : IObj = null;

            before(function() {
                meman = new Meman();
                managedObj = new MockObj(meman);
            });

            it('assigns a new ID when an object is created', function() {
                managedObj.get_objectId().should.be(1);

                var secondManagedObj = new Obj(meman);
                secondManagedObj.get_objectId().should.be(2);
            });

            it('increments the object reference count when added', function() {
                managedObj.get_refCount().should.be(0);
                meman.add(managedObj);
                managedObj.get_refCount().should.be(1);
                meman.add(managedObj);
                managedObj.get_refCount().should.be(2);
            });

            it('decrements the object reference count when removed', function() {
                meman.add(managedObj);
                meman.add(managedObj);
                managedObj.get_refCount().should.be(2);
            });

            it('returns the object instance from an ID', function() {
                meman.add(managedObj);
                var id = managedObj.get_objectId();
                var ref = meman.get(id);
                ref.should.be(managedObj);
            });

            it('returns null when no references are remaining', function() {
                meman.add(managedObj);
                meman.add(managedObj);
                managedObj.get_refCount().should.be(2);
                meman.remove(managedObj);
                managedObj.get_refCount().should.be(1);
                meman.remove(managedObj);
                meman.get(managedObj.get_objectId()).should.be(null);
            });

            it('automatically instantiates a new meman instance into the static variable', function() {
                Meman.inst = null;
                var memanClass = Type.getClass(meman);
                Type.getClass(Meman.inst).should.be(memanClass);
            });

            it('returns the same meman instance if it was previously set as static', function() {
                Meman.inst = meman;
                Meman.inst.should.be(meman);
            });

            it('initializes the refcount of an object to zero', function() {
                meman.initialize(managedObj);
                managedObj.get_refCount().should.be(0);
            });

            it('collects an object when parent refcount reaches 0', function() {
                var obj1 = new MockObj();
                var obj2 = new MockObj();
                var obj3 = new MockObj();

                Meman.inst.add(obj1);

                obj1.child1 = obj2;
                obj1.child2 = obj3;

                obj2.get_refCount().should.be(1);
                obj3.get_refCount().should.be(1);

                Meman.inst.remove(obj1);

                obj1.child1.should.be(null);
                obj2.child2.should.be(null);

                obj1.get_refCount().should.be(0);
                obj2.get_refCount().should.be(0);
            });

            it('correctly collects cyclical references', function() {
                var obj1 = new MockObj();
                var obj2 = new MockObj();

                Meman.inst.add(obj1);

                obj1.child1 = obj2;
                obj1.child2 = obj1;

                obj1.get_refCount().should.be(1);

                Meman.inst.remove(obj1);

                obj1.get_refCount().should.be(0);
            });
        });
    }
}
