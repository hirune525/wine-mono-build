using DotnetWebApp.Models;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace DotnetWebApp.Tests
{
    [TestClass]
    public class IndexViewModelTests
    {
        [TestMethod]
        public void Message_渡されたメッセージを表示()
        {
            var target = new IndexViewModel("message");
            Assert.AreEqual("message", target.Message);
        }
    }
}
