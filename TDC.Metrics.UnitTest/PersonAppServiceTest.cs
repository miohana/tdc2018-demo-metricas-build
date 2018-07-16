using TDC.Metrics.Application;
using TDC.Metrics.Application.Input;
using Xunit;

namespace TDC.Metrics.UnitTest
{
    public class PersonAppServiceTest
    {
        private PersonAppService _appService;
        public PersonAppServiceTest()
        {
            _appService = new PersonAppService();
        }

        [Fact]
        public void Deve_Ter_Salario_500()
        {
            var input = new PersonInput();

            input.Name = "Neymar";
            input.Surname = "Junior";
            input.Phone = "123456789";
            input.Salary = 20000.00;

            var retornoSalario = _appService.VerifySalary(input);

            Assert.Equal(500, retornoSalario);
        }

        [Fact]
        public void Deve_Manter_Salario()
        {
            var input = new PersonInput();

            input.Name = "Fernando";
            input.Surname = "Mendes";
            input.Phone = "123456789";
            input.Salary = 800.00;

            var retornoSalario = _appService.VerifySalary(input);

            Assert.Equal(800, retornoSalario);
        }
    }
}
