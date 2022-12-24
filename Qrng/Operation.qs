namespace Qrng {
    open Microsoft.Quantum.Intrinsic;

    operation GetNextRandomBit(): Result {
        use qubit = Qubit();
        H(qubit);
        return M(qubit);
    }

    @EntryPoint()
    operation PlayMorganasGame(): Unit {
        mutable nRounds = 0;
        mutable done = false;
        repeat {
            set nRounds = nRounds + 1;
            set done = (GetNextRandomBit() == Zero);
        }
        until done;

        Message($"It tool Lancelot {nRounds} turns to get home.");
    }
}