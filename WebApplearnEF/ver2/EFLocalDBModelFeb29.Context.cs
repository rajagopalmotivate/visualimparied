﻿//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace WebApplearnEF.ver2
{
    using System;
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    
    public partial class mylearnthinksavedbEntitiesFeb29 : DbContext
    {
        public mylearnthinksavedbEntitiesFeb29()
            : base("name=mylearnthinksavedbEntitiesFeb29")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
        public virtual DbSet<AudioURLTrascribedStringTAB> AudioURLTrascribedStringTAB { get; set; }
        public virtual DbSet<ListofQuestionsWithDetailsofEachQuestionTAB> ListofQuestionsWithDetailsofEachQuestionTAB { get; set; }
        public virtual DbSet<PhoneCoachingPlanListofSessionsTAB> PhoneCoachingPlanListofSessionsTAB { get; set; }
        public virtual DbSet<UserIdentityTAB> UserIdentityTAB { get; set; }
        public virtual DbSet<ListofQuestionPapersTAB> ListofQuestionPapersTAB { get; set; }
    }
}
