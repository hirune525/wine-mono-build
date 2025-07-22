namespace DotnetConsoleApp
{
    internal class Service
    {
        private readonly string _serviceName;

        public Service()
        {
            _serviceName = "DefaultService";
        }

        public Service(string serviceName)
        {
            _serviceName = serviceName;
        }

        public string GetName()
        {
            return _serviceName;
        }
    }
}
