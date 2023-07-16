using Dapper.Core.Entities;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace Dapper.Application.Interfaces
{
    public interface IInvoicesRepository : IGenericRepository<Invoices>
    {
        Task<IReadOnlyList<Invoices>> GetInvoicesWithPaging(PagingParams pagingParams);
        Task<int> GetInvoicesTotalAmount();
    }
}
