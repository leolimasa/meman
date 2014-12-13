package meman;

import buddy.Should;
import mockatoo.Mockatoo;
import meman.Managed;
import meman.IManaged;
import meman.Meman;
import meman.IMeman;
import buddy.BuddySuite;

import mockatoo.Mockatoo.*;
using mockatoo.Mockatoo;
using buddy.Should;

class MemanSpec extends BuddySuite {
    public function new() {
        describe("Memory manager", function() {
            var meman : IMeman = null;
            var managedObj : IManaged = null;

            before(function() {
                meman = new Meman();
                managedObj = new Managed();
            });

            it("assigns a new ID on add to an object without one", function() {
                managedObj.get_objectId().should.be(0);
                meman.add(managedObj);
                managedObj.get_objectId().should.beGreaterThan(0);
            });

            it("increments the object reference count when added", function() {
                managedObj.get_refCount().should.be(0);
                meman.add(managedObj);
                managedObj.get_refCount().should.be(1);
                meman.add(managedObj);
                managedObj.get_refCount().should.be(2);
            });

            it("decrements the object reference count when removed", function() {
                meman.add(managedObj);
                meman.add(managedObj);
                managedObj.get_refCount().should.be(2);
            });

            it("returns the object instance from an ID", function() {
                meman.add(managedObj);
                var id = managedObj.get_objectId();
                var ref = meman.get(id);
                ref.should.be(managedObj);
            });

            it("returns null when no references are remaining", function() {
                meman.add(managedObj);
                meman.add(managedObj);
                managedObj.get_refCount().should.be(2);
                meman.remove(managedObj);
                managedObj.get_refCount().should.be(1);
                meman.remove(managedObj);
                meman.get(managedObj.get_objectId()).should.be(null);
            });
        });
    }
}
