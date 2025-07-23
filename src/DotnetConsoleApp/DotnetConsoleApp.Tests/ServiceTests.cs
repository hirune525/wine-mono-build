using Microsoft.VisualStudio.TestTools.UnitTesting;
using System;

namespace DotnetConsoleApp.Tests
{
    [TestClass]
    public class ServiceTests
    {
        [TestMethod]
        public void GetName_パラメータのメッセージを出力する()
        {
            // Arrange
            var service = new Service("My Service");
            // Act
            var result = service.GetName();
            // Assert
            Assert.AreEqual("My Service", result);
        }
    }
}
