#pip install qiskit[visualization]
#pip install qiskit_aer
#pip install qiskit_ibm_runtime
#pip install pylatexenc
#pip install qiskit-transpiler-service


from qiskit import QuantumCircuit
from qiskit.quantum_info import Statevector
import qiskit.quantum_info as qi


def random_bit():
    qc = QuantumCircuit(1)
    qc.h(0) 

    sv = qi.Statevector(qc)
    counts = sv.sample_counts(1)  
    for key in counts:
        return int(key)  
