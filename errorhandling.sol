// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ShipmentTracking {

    enum Status { Pending, Shipped, Delivered, Cancelled }
    struct Order {
        uint id;
        address customer;
        Status status;
    }

    uint public nextOrderId;
    mapping(uint => Order) public orders;
    address public owner;

    constructor() {
        owner = msg.sender;
        nextOrderId = 1;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can perform this action");
        _;
    }

    function placeOrder() public {
        orders[nextOrderId] = Order(nextOrderId, msg.sender, Status.Pending);
        nextOrderId++;
    }

    function shipOrder(uint orderId) public onlyOwner {
        require(orders[orderId].status == Status.Pending, "Order must be in pending status");
        orders[orderId].status = Status.Shipped;
    }

    function deliverOrder(uint orderId) public onlyOwner {
        require(orders[orderId].status == Status.Shipped, "Order must be shipped first");
        orders[orderId].status = Status.Delivered;
    }

    function cancelOrder(uint orderId) public {
        require(msg.sender == orders[orderId].customer || msg.sender == owner, "Only the customer or owner can cancel the order");
        require(orders[orderId].status == Status.Pending, "Cannot cancel order unless it is pending");
        orders[orderId].status = Status.Cancelled;
    }

    function verifyOrder(uint orderId) public view returns (string memory) {
        if (orders[orderId].status == Status.Delivered) {
            return "Order has been delivered successfully.";
        } else {
            revert("Order is not delivered yet.");
        }
    }

    // Extra validation to demonstrate 'assert'
    function checkOrderIntegrity(uint orderId) public view {
        assert(orders[orderId].id == orderId); // Should always be true unless there's a severe bug
    }
}
