using Microsoft.VisualStudio.TestTools.UnitTesting;
using KastingKafeAPI.Controllers;
using System;
using System.Collections.Generic;
using System.Text;
using Microsoft.Extensions.Configuration;
using Moq;
using System.Net.Http;
using KastingKafeAPI.Entities;
using KastingKafeAPI.DataAccess;
using System.Linq;

namespace KastingKafeAPI.Controllers.Tests
{
    [TestClass()]
    public class BlockControllerTests
    {
        [TestMethod()]
        public void BlockControllerTest()
        {
            Assert.Fail();
        }

        [TestMethod()]
        public void GetTest()
        {
            var data = new[] { new Block { Id = 1, Body = "Title" }, new Block { Id = 2, Body = "No Title" } }.AsQueryable().ToList();
            var mock = new Mock<BlockDbContext>();
            mock.Setup(x => x.Set<Block>().ToList()).Returns(data);
            //Act
            var context = mock.Object;
            var blogs = context.Set<Block>();
            //Assert
            Assert.Equals(data, blogs);
        }
        [TestMethod()]
        public void GetTestBis()
        {
            /**var mock = new Mock<IConfiguration>();
            var blockCtr = new BlockController(mock.Object());
            mock.Setup(x => x.Set<Block>().ToList()).Returns(data);
            //Act
            var context = mock.Object;
            var blogs = context.Set<Block>();
            //Assert
            Assert.Equals(data, blogs);*/
        }
        
        [TestMethod()]
        public void GetByIdTest()
        {
            Assert.Fail();
        }

        [TestMethod()]
        public void DeleteTest()
        {
            Assert.Fail();
        }

        [TestMethod()]
        public void CreateTest()
        {
            Assert.Fail();
        }

        [TestMethod()]
        public void UpdateTest()
        {
            Assert.Fail();
        }
    }
}
