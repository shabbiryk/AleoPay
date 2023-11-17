// The 'invoice' program.
import credits.leo;

program invoice.aleo {
        struct InvoiceDetails {
        invoice_id: u64,
        payee: address,
        payer: address,
        amount: u64,
    }
mapping Subscription:u64  =>InvoiceDetails;
mapping Paid:bool  =>u64 ;

// Create new invoice
transition create_invoice (id2:u64,info2:InvoiceDetails) {
    return then finalize(id2,info2);
    

}
finalize create_invoice (id:u64,info:InvoiceDetails) {
    Mapping::set(Subscription,id,info);
    }

transition pay_invoice (id:u64,amount:u64,creds:credits.leo/credits.record,payee:address)   {
    credits.leo/transfer_private (creds,payee,amount);
    return then finalize (id,amount);
}
finalize pay_invoice ( id:u64,amount:u64) {
    let info :InvoiceDetails= Mapping::get(Subscription,id);
    Mapping::set(Subscription,id,InvoiceDetails{invoice_id:info.invoice_id,payee:info.payee,payer:info.payer,amount:info.amount-amount});
    }

}
