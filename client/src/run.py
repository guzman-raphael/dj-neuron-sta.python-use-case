import dj_neuron as dn
import time

start_time = time.time()
main = '/data'

# dn.createSchemaScratch(main,0.2)     # takes ~9[m]
# dn.updateSchemaComputationOnly(0.3)  # takes ~7.5[m]
# dn.addComputationComparison(0.2)       # takes ~7.5[m]

neuros_interest = [
    {'sample_number' : 3,'subject_name' : 'KO (chx10)','session_date' : '2008-06-06','neuron_id' : 0, 'strf_id' : 0},
    {'sample_number' : 2,'subject_name' : 'KO (chx10)','session_date' : '2008-06-24','neuron_id' : 0, 'strf_id' : 0},
    {'sample_number' : 1,'subject_name' : 'KO (pax6)','session_date' : '2008-05-16','neuron_id' : 0, 'strf_id' : 0}
]

# dn.convertTaskDataToJSON(main)

dn.saveVisualizations(neuros_interest,[1,3],main)  # takes ~8[s]

print("-----Final Time: {}[s]-----".format(time.time() - start_time))
