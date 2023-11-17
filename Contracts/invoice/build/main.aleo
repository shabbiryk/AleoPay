import credits.aleo;
program invoice.aleo;


struct InvoiceDetails:
    invoice_id as u64;
    payee as address;
    payer as address;
    amount as u64;


mapping Subscription:
	key as u64.public;
	value as InvoiceDetails.public;


mapping Paid:
	key as boolean.public;
	value as u64.public;

function create_invoice:
    input r0 as u64.private;
    input r1 as InvoiceDetails.private;
    async create_invoice r0 r1 into r2;
    output r2 as invoice.aleo/create_invoice.future;

finalize create_invoice:
    input r0 as u64.public;
    input r1 as InvoiceDetails.public;
    set r1 into Subscription[r0];


function pay_invoice:
    input r0 as u64.private;
    input r1 as u64.private;
    input r2 as credits.aleo/credits.record;
    input r3 as address.private;
    call credits.aleo/transfer_private r2 r3 r1 into r4 r5;
    async pay_invoice r0 r1 into r6;
    output r6 as invoice.aleo/pay_invoice.future;

finalize pay_invoice:
    input r0 as u64.public;
    input r1 as u64.public;
    get Subscription[r0] into r2;
    sub r2.amount r1 into r3;
    cast r2.invoice_id r2.payee r2.payer r3 into r4 as InvoiceDetails;
    set r4 into Subscription[r0];
