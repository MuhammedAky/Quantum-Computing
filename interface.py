#!/bin/env python

# interface to the qubit

from abc import ABCMeta, abstractmethod
from contextlib import contextmanager

class Qubit(metaclass = ABCMeta):

    @abstractmethod
    def swap(self, swap_target: "Qubit"): pass

    @abstractmethod
    def cnot(self, cnot_target: "Qubit"): pass

    @abstractmethod
    def h(self): pass

    @abstractmethod
    def x(self): pass

    @abstractmethod
    def y(self): pass

    @abstractmethod
    def z(self): pass

    @abstractmethod
    def ry(self, angle: float): pass

    @abstractmethod
    def measure(self) -> bool: pass

    @abstractmethod
    def reset(self): pass

class QuantumDevice(metaclass = ABCMeta):
    @abstractmethod
    def allocate_qubit(self) -> Qubit:
        pass

    @abstractmethod
    def deallocate_qubit(self, qubit: Qubit):
        pass

    @contextmanager
    def using_qubit(self):
        qubit = self.allocate_qubit()

        try:
            yield qubit
        finally:
            qubit.reset()
            self.deallocate_qubit(qubit)

    @contextmanager
    def using_register(self, n_qubits = 1):
        qubits = [
            self.allocate_qubit()
            for idx in range(n_qubits)
        ]
        try:
            yield qubits
        finally:
            for qubit in qubits:
                qubit.reset()
                self.deallocate_qubit(qubit)