namespace TDC.Metrics.Domain
{
    public class Person
    {
        public string Name { get; set; }
        public string Surname { get; set; }
        public string Phone { get; set; }
        public double Salary { get; set; }


        public void CalculateSalary()
        {
            this.Salary = this.Salary * 0.10;
        }
    }
}
