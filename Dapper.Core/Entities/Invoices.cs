using System;
using System.Collections.Generic;
using System.Text;

namespace Dapper.Core.Entities
{

    public enum InvoiceType
    {
        Open = 1,
        Closed = 2,
     
    }

    public class Invoices
    {


        public Guid InvoiceId { get; set; }
        public string InvoiceName { get; set; }
        public int Amount { get; set; }
        public DateTime CreatedAt { get; set; }
        public DateTime DeletedAt { get; set; }
        public InvoiceType InvoiceType { get; set; }
        public string InvoiceTypeDesc { get; set; }

    }
}
