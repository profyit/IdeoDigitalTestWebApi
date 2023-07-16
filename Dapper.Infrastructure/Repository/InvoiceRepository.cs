using Dapper.Application.Interfaces;
using Dapper.Core.Entities;
using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;

namespace Dapper.Infrastructure.Repository
{
    public class InvoicesRepository : IInvoicesRepository
    {
        private readonly IConfiguration configuration;
        public InvoicesRepository(IConfiguration configuration)
        {
            this.configuration = configuration;
        }
       
        string DeleteInvoiceByID = "DeteleInvoiceByID";
        string AddInvoice = "AddInvoice";
        string GetInvoicesWithPagingSP = "GetInvoicesWithPaging";
        string GetAllInvoicesSP = "GetAllInvoices";
        string GetInvoiceByID = "GetInvoiceByID";
        string UpdateInvoice = "UpdateInvoice";
        
        public async Task<int> AddAsync(Invoices entity)
        {
            using (var connection = new SqlConnection(configuration.GetConnectionString("DefaultConnection")))
            {
                connection.Open();
                DynamicParameters parameters = new DynamicParameters();    
                parameters.Add("InvoiceName", entity.InvoiceName);
                parameters.Add("Amount", entity.Amount);
                parameters.Add("InvoiceType", (int)entity.InvoiceType);
           
                var res = await connection.QuerySingleOrDefaultAsync<int>(AddInvoice, parameters, commandType: CommandType.StoredProcedure);
                return res;
            }
        }

        public async Task<int> DeleteAsync(Guid id)
        {
            using (var connection = new SqlConnection(configuration.GetConnectionString("DefaultConnection")))
            {
                connection.Open();
                DynamicParameters parameters = new DynamicParameters();
                parameters.Add("InvoiceID", id);
                var res =  await connection.QuerySingleOrDefaultAsync<int>(DeleteInvoiceByID, parameters, commandType: CommandType.StoredProcedure);
                return res;
            }
            
        }

        public async Task<IReadOnlyList<Invoices>> GetAllAsync()
        {
            using (var connection = new SqlConnection(configuration.GetConnectionString("DefaultConnection")))
            {
                connection.Open();
                DynamicParameters parameters = new DynamicParameters();
               
                var res = await connection.QueryAsync<Invoices>(GetAllInvoicesSP, null, commandType: CommandType.StoredProcedure);
                return (IReadOnlyList<Invoices>)res;
            }
        }

        public async Task<Invoices> GetByIdAsync(Guid invoiceID)
        {
         
            using (var connection = new SqlConnection(configuration.GetConnectionString("DefaultConnection")))
            {
                connection.Open();

                DynamicParameters parameters = new DynamicParameters();
                parameters.Add("InvoiceID", invoiceID);
                var result = await connection.QuerySingleOrDefaultAsync<Invoices>(GetInvoiceByID, parameters, commandType: CommandType.StoredProcedure);
                return result;
            }
          
        }

        public async Task<int> UpdateAsync(Invoices Invoice)
        {

            using (var connection = new SqlConnection(configuration.GetConnectionString("DefaultConnection")))
            {
                connection.Open();
                DynamicParameters parameters = new DynamicParameters();
                parameters.Add("InvoiceID", Invoice.InvoiceId);
                parameters.Add("InvoiceName", Invoice.InvoiceName);
                parameters.Add("Amount", Invoice.Amount);
                parameters.Add("InvoiceType", Invoice.InvoiceType);
                var res = await connection.QuerySingleOrDefaultAsync<int>(UpdateInvoice, parameters, commandType: CommandType.StoredProcedure);
                return res;
            }
        }

        public async Task<IReadOnlyList<Invoices>> GetInvoicesWithPaging(PagingParams pagingParams)
        {
            using (var connection = new SqlConnection(configuration.GetConnectionString("DefaultConnection")))
            {
                connection.Open();
                DynamicParameters parameters = new DynamicParameters();
                parameters.Add("page", pagingParams.Page);
                parameters.Add("limit", pagingParams.Limit);

                var res = await connection.QueryAsync<Invoices>(GetInvoicesWithPagingSP, parameters, commandType: CommandType.StoredProcedure);
                return (IReadOnlyList<Invoices>)res;
            }
           
        }


        
        public Task<int> DeleteAsync(int id)
        {
            throw new NotImplementedException("TODO: later");
        }

        public Task<int> GetInvoicesTotalAmount()
        {
            var allInvoices = GetAllAsync().Result;
            return Task.FromResult(allInvoices.ToList().Sum(r => r.Amount));
        }

        
    }
}
