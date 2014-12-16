package meman;

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
                managedObj = new Obj(meman);
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

            it('recursivelly removes attributes of an object from memory', function() {

            });
        });
    }
}
