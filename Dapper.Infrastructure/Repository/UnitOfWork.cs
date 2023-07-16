using Dapper.Application.Interfaces;
using System;
using System.Collections.Generic;
using System.Text;

namespace Dapper.Infrastructure.Repository
{
    public class UnitOfWork : IUnitOfWork
    {

        public UnitOfWork(IInvoicesRepository InvoicesRepository)
        {
            Invoices = InvoicesRepository;
        }
        public IInvoicesRepository Invoices { get; }
    }
}
