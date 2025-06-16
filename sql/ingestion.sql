create or replace file format csv_ff
type = 'csv'
field_delimiter = ','
skip_header = 1
null_if = ('', 'null');

create or replace stage local_stage
url = 'file://<local-inbox-folder-path>';

copy into raw.merchants
from @local_stage
pattern = '.*merchants_.*\.csv'
file_format = csv_ff
on_error = 'continue';

copy into raw.applications
from @local_stage
pattern = '.*applications_.*\.csv'
file_format = csv_ff
on_error = 'continue';

copy into raw.disbursements
from @local_stage
pattern = '.*disbursements_.*\.csv'
file_format = csv_ff
on_error = 'continue';

copy into raw.payments
from @local_stage
pattern = '.*payments_.*\.csv'
file_format = csv_ff
on_error = 'continue';
