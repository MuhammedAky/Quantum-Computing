#!/bin/env python

from interface import QuantumDevice, Qubit
from simulator import Simulator

def teleport(msg: Qubit, here: Qubit, there: Qubit) -> None:
    here.h()
    here.cnot(there)

    msg.cnot(here)
    msg.h()

    if msg.measure(): there.z()
    if here.measure(): there.x()

    msg.reset()
    here.reset()

if __name__ == "__main__":
    sim = Simulator(capacity=3)
    with sim.using_register(3) as (msg, here, there):
        msg.ry(0.123)
        teleport(msg, here, there)

        there.ry(-0.123)
        sim.dump()