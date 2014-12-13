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
                managedObj.getObjectId().should.be(0);
                meman.add(managedObj);
                managedObj.getObjectId().should.beGreaterThan(0);
            });

            it("increments the object reference count when added", function() {
                managedObj.getRefCount().should.be(0);
                meman.add(managedObj);
                managedObj.getRefCount().should.be(1);
                meman.add(managedObj);
                managedObj.getRefCount().should.be(2);
            });

            it("decrements the object reference count when removed", function() {
                meman.add(managedObj);
                meman.add(managedObj);
                managedObj.getRefCount().should.be(2);
            });

            it("returns the object instance from an ID", function() {
                meman.add(managedObj);
                var id = managedObj.getObjectId();
                var ref = meman.get(id);
                ref.should.be(managedObj);
            });

            it("returns null when no references are remaining", function() {
                meman.add(managedObj);
                meman.add(managedObj);
                managedObj.getRefCount().should.be(2);
                meman.remove(managedObj);
                managedObj.getRefCount().should.be(1);
                meman.remove(managedObj);
                meman.get(managedObj.getObjectId()).should.be(null);
            });
        });
    }
}
