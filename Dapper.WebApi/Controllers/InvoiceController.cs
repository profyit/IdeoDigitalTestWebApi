using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Dapper.Application.Interfaces;
using Dapper.Core.Entities;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace Dapper.WebApi.Controllers
{
    /// <summary>
    /// 
    /// </summary>
    [Route("api/[controller]")]
    [ApiController]
    public class InvoicesController : ControllerBase
    {
        private readonly IUnitOfWork unitOfWork;
        /// <summary>
        /// 
        /// </summary>
        /// <param name="unitOfWork"></param>
        public InvoicesController(IUnitOfWork unitOfWork)
        {
            this.unitOfWork = unitOfWork;
        }
     
    
        [HttpGet]
       
        public async Task<IActionResult> GetAll()
        {
            var data = await unitOfWork.Invoices.GetAllAsync();
            return Ok(data);
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>

        [HttpGet("{id}")]
     
        public async Task<IActionResult> GetById(Guid id)
        {
            var data = await unitOfWork.Invoices.GetByIdAsync(id);
            if (data == null) return Ok();
            return Ok(data);
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="Invoices"></param>
        /// <returns></returns>
        [HttpPost]
        public async Task<IActionResult> Add(Invoices Invoices)
        {
            var data = await unitOfWork.Invoices.AddAsync(Invoices);
            return Ok(data);
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [HttpDelete("{id:Guid}")]
        public async Task<IActionResult> Delete(Guid id)
        {
            var data = await unitOfWork.Invoices.DeleteAsync(id);
            return Ok(data);
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="Invoices"></param>
        /// <returns></returns>
        [HttpPut]
        public async Task<IActionResult> Update(Invoices Invoices)
        {
            var data = await unitOfWork.Invoices.UpdateAsync(Invoices);
            return Ok(data);
        }
        /// <summary>
        /// 
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        [Route("TotalAmount")]
        public async Task<IActionResult> GetInvoicesAmount()
        {
            var totalAge = await unitOfWork.Invoices.GetInvoicesTotalAmount();
            return Ok(totalAge);
        }

    }
}