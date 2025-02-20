﻿using CharityAPI.IServices;
using CharityAPI.Models;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace CharityAPI.Services
{
    public class UrgencyServices: GenericRepository<Urgency>, IUrgency
    {
        public UrgencyServices(CharityAPIContext context) : base(context)
        {

        }

        //create urgency
        public override bool Create(Urgency urgency)
        {
            var result = context.Urgency.Add(urgency);
            context.SaveChanges();
            return true;
        }

        //get all urgency 
        public override IEnumerable<Urgency> GetAll()
        {
            var urgency = context.Urgency;
            //var urgency = context.Urgency.FromSqlRaw("exec getAllUrgency").ToList();

            return urgency;
        }

        //get urgency by urgency id
        public IEnumerable<Urgency> GetUrgencyById(long id)
        {

            //var param = new SqlParameter("@uid", id);
            //var urgency = context.Urgency.FromSqlRaw("exec getUrgencyByUrgencyId {0}", param).ToList();
            var urgency = context.Urgency.Where(x=>x.UrgencyId==id);

            return urgency;
        }

        //get urgency by post id
        //public IEnumerable GetUrgencyByPostId(long postid)
        //{

        //    //var param = new SqlParameter("@postid", postid);
        //    //var urgency = context.Urgency.FromSqlRaw("exec getUrgencyByPostId {0}", param).ToList();
        //    var urgency = context.Urgency.Where(x => x.PostId == postid).ToList();

        //    return urgency;
        //}


        public IEnumerable GetUrgencyByPostId(long id)
        {
            var spam = context.Urgency.Where(x => x.PostId == id && x.IsPublished == true).Include(x => x.User);
            return spam;
        }

        //get urgency by user id
        public IEnumerable GetUrgencyByUserId(long userid)
        {

            //var param = new SqlParameter("@userid", userid);
            //var urgency = context.Urgency.FromSqlRaw("exec getUrgencyByPostId {0}", param).ToList();
            var urgency = context.Urgency.Where(x => x.UserId == userid).ToList();

            return urgency;
        }

        //update urgency
        public override bool Update(long id, Urgency urgency)
        {
            var existingurgency = context.Urgency.Find(id);

            if (existingurgency != null)
            {
                
                existingurgency.UserId = urgency.UserId;
                existingurgency.UpdatedBy = urgency.UpdatedBy;
                existingurgency.UpdatedAt = DateTime.Now;
                context.SaveChanges();
                return true;
            }
            else
            {
                return false;
            }

        }
        public Urgency CheckUrgency(long userid, long postId)
        {
            var urgency = context.Urgency.SingleOrDefault(x => x.UserId == userid && x.PostId==postId);
            return urgency;
            
        }

        //delete urgency

        public override bool Delete(long id)
        {
            var existingurgency = context.Urgency.Find(id);

            if (existingurgency != null)
            {
                context.Urgency.Remove(existingurgency);
                context.SaveChanges();
                return true;
            }
            else
            {
                return false;
            }
        }

    }
}
