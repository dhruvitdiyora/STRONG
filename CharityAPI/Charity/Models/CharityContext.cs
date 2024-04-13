using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;

// Code scaffolded by EF Core assumes nullable reference types (NRTs) are not used or disabled.
// If you have enabled NRTs for your project, then un-comment the following line:
// #nullable disable

namespace CharityAPI.Models
{
    public partial class CharityContext : DbContext
    {
        public CharityContext()
        {
        }

        public CharityContext(DbContextOptions<CharityContext> options)
            : base(options)
        {
        }

        public virtual DbSet<Admins> Admins { get; set; }
        public virtual DbSet<CharityEvent> CharityEvent { get; set; }
        public virtual DbSet<CharityEventInteract> CharityEventInteract { get; set; }
        public virtual DbSet<CharityEventOrganiser> CharityEventOrganiser { get; set; }
        public virtual DbSet<CharityEventPost> CharityEventPost { get; set; }
        public virtual DbSet<CharityEventPostLike> CharityEventPostLike { get; set; }
        public virtual DbSet<Cities> Cities { get; set; }
        public virtual DbSet<ClusterLocations> ClusterLocations { get; set; }
        public virtual DbSet<OrganisationData> OrganisationData { get; set; }
        public virtual DbSet<Organisations> Organisations { get; set; }
        public virtual DbSet<Pincode> Pincode { get; set; }
        public virtual DbSet<Post> Post { get; set; }
        public virtual DbSet<PostComments> PostComments { get; set; }
        public virtual DbSet<PostImages> PostImages { get; set; }
        public virtual DbSet<RequirementType> RequirementType { get; set; }
        public virtual DbSet<Spam> Spam { get; set; }
        public virtual DbSet<States> States { get; set; }
        public virtual DbSet<Urgency> Urgency { get; set; }
        public virtual DbSet<UserData> UserData { get; set; }
        public virtual DbSet<Users> Users { get; set; }
        public virtual DbSet<Volunteer> Volunteer { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Admins>(entity =>
            {
                entity.HasKey(e => e.AdminId);

                entity.HasIndex(e => e.EmailAddress)
                    .HasName("UQ__Admins__49A147403EA71956")
                    .IsUnique();

                entity.HasIndex(e => e.PasswordHash)
                    .HasName("UQ__Admins__D60E46A230094F7A")
                    .IsUnique();

                entity.HasIndex(e => e.UserName)
                    .HasName("UQ__Admins__C9F284567F6EB297")
                    .IsUnique();

                entity.Property(e => e.CreatedAt).HasColumnType("datetime");

                entity.Property(e => e.CreatedBy)
                    .IsRequired()
                    .HasMaxLength(50);

                entity.Property(e => e.EmailAddress)
                    .IsRequired()
                    .HasMaxLength(50);

                entity.Property(e => e.IsPublished)
                    .IsRequired()
                    .HasDefaultValueSql("((1))");

                entity.Property(e => e.MobileNo)
                    .IsRequired()
                    .HasMaxLength(50);

                entity.Property(e => e.PasswordHash)
                    .IsRequired()
                    .HasMaxLength(100);

                entity.Property(e => e.UpdatedAt).HasColumnType("datetime");

                entity.Property(e => e.UpdatedBy)
                    .IsRequired()
                    .HasMaxLength(50);

                entity.Property(e => e.UserName)
                    .IsRequired()
                    .HasMaxLength(50);
            });

            modelBuilder.Entity<CharityEvent>(entity =>
            {
                entity.HasKey(e => e.EventId);

                entity.Property(e => e.CreatedAt).HasColumnType("datetime");

                entity.Property(e => e.CreatedBy)
                    .IsRequired()
                    .HasMaxLength(50);

                entity.Property(e => e.EventBannerUrl)
                    .IsRequired()
                    .HasColumnName("EventBannerURL");

                entity.Property(e => e.EventDescription)
                    .IsRequired()
                    .HasColumnType("text");

                entity.Property(e => e.EventEndDate).HasColumnType("datetime");

                entity.Property(e => e.EventName)
                    .IsRequired()
                    .HasMaxLength(50);

                entity.Property(e => e.EventStartDate).HasColumnType("datetime");

                entity.Property(e => e.EventType)
                    .IsRequired()
                    .HasMaxLength(50);

                entity.Property(e => e.IsPublished)
                    .IsRequired()
                    .HasDefaultValueSql("((1))");

                entity.Property(e => e.UpdatedAt).HasColumnType("datetime");

                entity.Property(e => e.UpdatedBy)
                    .IsRequired()
                    .HasMaxLength(50);

                entity.HasOne(d => d.EventOrganiser)
                    .WithMany(p => p.CharityEvent)
                    .HasForeignKey(d => d.EventOrganiserId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_CharityOrganisationId");

                entity.HasOne(d => d.Pincode)
                    .WithMany(p => p.CharityEvent)
                    .HasForeignKey(d => d.PincodeId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_CharityEventPincodeId");
            });

            modelBuilder.Entity<CharityEventInteract>(entity =>
            {
                entity.Property(e => e.CreatedAt).HasColumnType("datetime");

                entity.Property(e => e.CreatedBy)
                    .IsRequired()
                    .HasMaxLength(50);

                entity.Property(e => e.IsPublished)
                    .IsRequired()
                    .HasDefaultValueSql("((1))");

                entity.Property(e => e.UpdatedAt).HasColumnType("datetime");

                entity.Property(e => e.UpdatedBy)
                    .IsRequired()
                    .HasMaxLength(50);

                entity.HasOne(d => d.Event)
                    .WithMany(p => p.CharityEventInteract)
                    .HasForeignKey(d => d.EventId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_CharityEventInteractEvent");

                entity.HasOne(d => d.User)
                    .WithMany(p => p.CharityEventInteract)
                    .HasForeignKey(d => d.UserId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_CharityEventInteractUser");
            });

            modelBuilder.Entity<CharityEventOrganiser>(entity =>
            {
                entity.HasIndex(e => new { e.EventOrganiserId, e.EventId })
                    .HasName("UK_CharityEventOrganiserEventNOrganiser")
                    .IsUnique();

                entity.Property(e => e.CreatedAt).HasColumnType("datetime");

                entity.Property(e => e.CreatedBy)
                    .IsRequired()
                    .HasMaxLength(50);

                entity.Property(e => e.IsPublished)
                    .IsRequired()
                    .HasDefaultValueSql("((1))");

                entity.Property(e => e.UpdatedAt).HasColumnType("datetime");

                entity.Property(e => e.UpdatedBy)
                    .IsRequired()
                    .HasMaxLength(50);

                entity.HasOne(d => d.Event)
                    .WithMany(p => p.CharityEventOrganiser)
                    .HasForeignKey(d => d.EventId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_CharityEventOrganiserEvent");

                entity.HasOne(d => d.EventOrganiser)
                    .WithMany(p => p.CharityEventOrganiser)
                    .HasForeignKey(d => d.EventOrganiserId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_CharityEventOrganiserEventOrganiser");
            });

            modelBuilder.Entity<CharityEventPost>(entity =>
            {
                entity.Property(e => e.Content).HasColumnType("text");

                entity.Property(e => e.CreatedAt).HasColumnType("datetime");

                entity.Property(e => e.CreatedBy)
                    .IsRequired()
                    .HasMaxLength(50);

                entity.Property(e => e.IsPublished)
                    .IsRequired()
                    .HasDefaultValueSql("((1))");

                entity.Property(e => e.PostUrl).IsRequired();

                entity.Property(e => e.UpdatedAt).HasColumnType("datetime");

                entity.Property(e => e.UpdatedBy)
                    .IsRequired()
                    .HasMaxLength(50);

                entity.HasOne(d => d.Event)
                    .WithMany(p => p.CharityEventPost)
                    .HasForeignKey(d => d.EventId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_CharityEventPostEvent");

                entity.HasOne(d => d.User)
                    .WithMany(p => p.CharityEventPost)
                    .HasForeignKey(d => d.UserId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_CharityEventPostUser");
            });

            modelBuilder.Entity<CharityEventPostLike>(entity =>
            {
                entity.HasIndex(e => new { e.CharityEventPostId, e.UserId })
                    .HasName("UK_CharityEventPostUser")
                    .IsUnique();

                entity.Property(e => e.CreatedAt).HasColumnType("datetime");

                entity.Property(e => e.CreatedBy)
                    .IsRequired()
                    .HasMaxLength(50);

                entity.Property(e => e.UpdatedAt).HasColumnType("datetime");

                entity.Property(e => e.UpdatedBy)
                    .IsRequired()
                    .HasMaxLength(50);

                entity.HasOne(d => d.CharityEventPost)
                    .WithMany(p => p.CharityEventPostLike)
                    .HasForeignKey(d => d.CharityEventPostId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_CharityEventPost");

                entity.HasOne(d => d.User)
                    .WithMany(p => p.CharityEventPostLike)
                    .HasForeignKey(d => d.UserId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_CharityEventLikeByUser");
            });

            modelBuilder.Entity<Cities>(entity =>
            {
                entity.HasKey(e => e.CityId);

                entity.Property(e => e.CityName)
                    .IsRequired()
                    .HasMaxLength(50);

                entity.Property(e => e.CreatedAt).HasColumnType("datetime");

                entity.Property(e => e.CreatedBy)
                    .IsRequired()
                    .HasMaxLength(50);

                entity.Property(e => e.IsPublished)
                    .IsRequired()
                    .HasDefaultValueSql("((1))");

                entity.Property(e => e.UpdatedAt).HasColumnType("datetime");

                entity.Property(e => e.UpdatedBy)
                    .IsRequired()
                    .HasMaxLength(50);

                entity.HasOne(d => d.State)
                    .WithMany(p => p.Cities)
                    .HasForeignKey(d => d.StateId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Cities");
            });

            modelBuilder.Entity<ClusterLocations>(entity =>
            {
                entity.HasKey(e => e.ClusterLocationId)
                    .HasName("PK_Cluster");

                entity.Property(e => e.ClusterDetails)
                    .IsRequired()
                    .HasMaxLength(50);

                entity.Property(e => e.CreatedAt).HasColumnType("datetime");

                entity.Property(e => e.CreatedBy)
                    .IsRequired()
                    .HasMaxLength(50);

                entity.Property(e => e.IsPublished)
                    .IsRequired()
                    .HasDefaultValueSql("((1))");

                entity.Property(e => e.UpdatedAt).HasColumnType("datetime");

                entity.Property(e => e.UpdatedBy)
                    .IsRequired()
                    .HasMaxLength(50);

                entity.HasOne(d => d.City)
                    .WithMany(p => p.ClusterLocations)
                    .HasForeignKey(d => d.CityId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_ClusterCity");

                entity.HasOne(d => d.Pincode)
                    .WithMany(p => p.ClusterLocations)
                    .HasForeignKey(d => d.PincodeId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_ClusterPin");

                entity.HasOne(d => d.Post)
                    .WithMany(p => p.ClusterLocations)
                    .HasForeignKey(d => d.PostId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_ClusterPostId");

                entity.HasOne(d => d.RequirementType)
                    .WithMany(p => p.ClusterLocations)
                    .HasForeignKey(d => d.RequirementTypeId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_ClusterControId");

                entity.HasOne(d => d.State)
                    .WithMany(p => p.ClusterLocations)
                    .HasForeignKey(d => d.StateId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_ClusterState");
            });

            modelBuilder.Entity<OrganisationData>(entity =>
            {
                entity.Property(e => e.CreatedAt).HasColumnType("datetime");

                entity.Property(e => e.CreatedBy)
                    .IsRequired()
                    .HasMaxLength(50);

                entity.Property(e => e.IsPublished)
                    .IsRequired()
                    .HasDefaultValueSql("((1))");

                entity.Property(e => e.OrganisatioWebUrl).HasColumnName("OrganisatioWebURL");

                entity.Property(e => e.OrganisationAddress).IsRequired();

                entity.Property(e => e.OrganisationContactNo).HasMaxLength(50);

                entity.Property(e => e.OrganisationLogoUrl)
                    .IsRequired()
                    .HasColumnName("OrganisationLogoURL");

                entity.Property(e => e.OrganisationName)
                    .IsRequired()
                    .HasMaxLength(50);

                entity.Property(e => e.OrganisationUserName).HasMaxLength(50);

                entity.Property(e => e.UpdatedAt).HasColumnType("datetime");

                entity.Property(e => e.UpdatedBy)
                    .IsRequired()
                    .HasMaxLength(50);

                entity.HasOne(d => d.OrganisationUser)
                    .WithMany(p => p.OrganisationData)
                    .HasForeignKey(d => d.OrganisationUserId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_OrgUser");
            });

            modelBuilder.Entity<Organisations>(entity =>
            {
                entity.HasKey(e => e.OrganisationId);

                entity.HasIndex(e => e.EmailAddress)
                    .HasName("UQ__Organisa__49A147404CC6C36B")
                    .IsUnique();

                entity.HasIndex(e => e.PasswordHash)
                    .HasName("UQ__Organisa__D60E46A29E1E2CC3")
                    .IsUnique();

                entity.HasIndex(e => e.UserName)
                    .HasName("UQ__Organisa__C9F28456752AB044")
                    .IsUnique();

                entity.Property(e => e.CreatedAt).HasColumnType("datetime");

                entity.Property(e => e.CreatedBy)
                    .IsRequired()
                    .HasMaxLength(50);

                entity.Property(e => e.EmailAddress)
                    .IsRequired()
                    .HasMaxLength(50);

                entity.Property(e => e.IsPublished)
                    .IsRequired()
                    .HasDefaultValueSql("((1))");

                entity.Property(e => e.MobileNo)
                    .IsRequired()
                    .HasMaxLength(50);

                entity.Property(e => e.OtpCreatedAt).HasColumnType("datetime");

                entity.Property(e => e.PasswordHash)
                    .IsRequired()
                    .HasMaxLength(100);

                entity.Property(e => e.UpdatedAt).HasColumnType("datetime");

                entity.Property(e => e.UpdatedBy)
                    .IsRequired()
                    .HasMaxLength(50);

                entity.Property(e => e.UserName)
                    .IsRequired()
                    .HasMaxLength(50);
            });

            modelBuilder.Entity<Pincode>(entity =>
            {
                entity.Property(e => e.CreatedAt).HasColumnType("datetime");

                entity.Property(e => e.CreatedBy)
                    .IsRequired()
                    .HasMaxLength(50);

                entity.Property(e => e.District)
                    .HasMaxLength(100)
                    .IsUnicode(false);

                entity.Property(e => e.IsPublished)
                    .IsRequired()
                    .HasDefaultValueSql("((1))");

                entity.Property(e => e.Pincode1).HasColumnName("Pincode");

                entity.Property(e => e.PostOfficeName)
                    .HasMaxLength(100)
                    .IsUnicode(false);

                entity.Property(e => e.UpdatedAt).HasColumnType("datetime");

                entity.Property(e => e.UpdatedBy)
                    .IsRequired()
                    .HasMaxLength(50);

                entity.HasOne(d => d.City)
                    .WithMany(p => p.Pincode)
                    .HasForeignKey(d => d.CityId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_PincodeCity");

                entity.HasOne(d => d.State)
                    .WithMany(p => p.Pincode)
                    .HasForeignKey(d => d.StateId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_PincodeState");
            });

            modelBuilder.Entity<Post>(entity =>
            {
                entity.Property(e => e.CloseAt).HasColumnType("datetime");

                entity.Property(e => e.CreatedAt).HasColumnType("datetime");

                entity.Property(e => e.CreatedBy)
                    .IsRequired()
                    .HasMaxLength(50);

                entity.Property(e => e.ImageUrl)
                    .IsRequired()
                    .HasColumnName("ImageURL");

                entity.Property(e => e.IsPublished)
                    .IsRequired()
                    .HasDefaultValueSql("((1))");

                entity.Property(e => e.Latitude).HasColumnType("decimal(12, 9)");

                entity.Property(e => e.LocationName)
                    .IsRequired()
                    .HasMaxLength(50);

                entity.Property(e => e.Longitude).HasColumnType("decimal(12, 9)");

                entity.Property(e => e.PostDescription)
                    .IsRequired()
                    .HasColumnType("text");

                entity.Property(e => e.UpdatedAt).HasColumnType("datetime");

                entity.Property(e => e.UpdatedBy)
                    .IsRequired()
                    .HasMaxLength(50);

                entity.HasOne(d => d.City)
                    .WithMany(p => p.Post)
                    .HasForeignKey(d => d.CityId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_PostCity");

                entity.HasOne(d => d.Pincode)
                    .WithMany(p => p.Post)
                    .HasForeignKey(d => d.PincodeId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_PostPin");

                entity.HasOne(d => d.RequirementType)
                    .WithMany(p => p.Post)
                    .HasForeignKey(d => d.RequirementTypeId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_RequirementType");

                entity.HasOne(d => d.State)
                    .WithMany(p => p.Post)
                    .HasForeignKey(d => d.StateId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_PostState");

                entity.HasOne(d => d.User)
                    .WithMany(p => p.Post)
                    .HasForeignKey(d => d.UserId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_PostUserId");
            });

            modelBuilder.Entity<PostComments>(entity =>
            {
                entity.HasKey(e => e.PostCommentId)
                    .HasName("PK_PostComment");

                entity.Property(e => e.Comment)
                    .IsRequired()
                    .HasColumnType("text");

                entity.Property(e => e.CreatedAt).HasColumnType("datetime");

                entity.Property(e => e.CreatedBy)
                    .IsRequired()
                    .HasMaxLength(50);

                entity.Property(e => e.IsPublished)
                    .IsRequired()
                    .HasDefaultValueSql("((1))");

                entity.Property(e => e.UpdatedAt).HasColumnType("datetime");

                entity.Property(e => e.UpdatedBy)
                    .IsRequired()
                    .HasMaxLength(50);

                entity.HasOne(d => d.Post)
                    .WithMany(p => p.PostComments)
                    .HasForeignKey(d => d.PostId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_PostComPostId");

                entity.HasOne(d => d.User)
                    .WithMany(p => p.PostComments)
                    .HasForeignKey(d => d.UserId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_PostComUserId");
            });

            modelBuilder.Entity<PostImages>(entity =>
            {
                entity.Property(e => e.CreatedAt).HasColumnType("datetime");

                entity.Property(e => e.CreatedBy)
                    .IsRequired()
                    .HasMaxLength(50);

                entity.Property(e => e.ImageUrl1)
                    .IsRequired()
                    .HasColumnName("ImageURL1");

                entity.Property(e => e.ImageUrl2).HasColumnName("ImageURL2");

                entity.Property(e => e.ImageUrl3).HasColumnName("ImageURL3");

                entity.Property(e => e.ImageUrl4).HasColumnName("ImageURL4");

                entity.Property(e => e.UpdatedAt).HasColumnType("datetime");

                entity.Property(e => e.UpdatedBy)
                    .IsRequired()
                    .HasMaxLength(50);

                entity.HasOne(d => d.Post)
                    .WithMany(p => p.PostImages)
                    .HasForeignKey(d => d.PostId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_PostImgPostId");

                entity.HasOne(d => d.User)
                    .WithMany(p => p.PostImages)
                    .HasForeignKey(d => d.UserId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_PostImgUserId");
            });

            modelBuilder.Entity<RequirementType>(entity =>
            {
                entity.Property(e => e.CreatedAt).HasColumnType("datetime");

                entity.Property(e => e.CreatedBy)
                    .IsRequired()
                    .HasMaxLength(50);

                entity.Property(e => e.IsPublished)
                    .IsRequired()
                    .HasDefaultValueSql("((1))");

                entity.Property(e => e.RequirementTypeName)
                    .IsRequired()
                    .HasMaxLength(50);

                entity.Property(e => e.UpdatedAt).HasColumnType("datetime");

                entity.Property(e => e.UpdatedBy)
                    .IsRequired()
                    .HasMaxLength(50);
            });

            modelBuilder.Entity<Spam>(entity =>
            {
                entity.HasIndex(e => new { e.PostId, e.UserId })
                    .HasName("UK_SpamUser")
                    .IsUnique();

                entity.Property(e => e.CreatedAt).HasColumnType("datetime");

                entity.Property(e => e.CreatedBy)
                    .IsRequired()
                    .HasMaxLength(50);

                entity.Property(e => e.IsPublished)
                    .IsRequired()
                    .HasDefaultValueSql("((1))");

                entity.Property(e => e.UpdatedAt).HasColumnType("datetime");

                entity.Property(e => e.UpdatedBy)
                    .IsRequired()
                    .HasMaxLength(50);

                entity.HasOne(d => d.Post)
                    .WithMany(p => p.Spam)
                    .HasForeignKey(d => d.PostId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_SpamPost");

                entity.HasOne(d => d.User)
                    .WithMany(p => p.Spam)
                    .HasForeignKey(d => d.UserId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_SpamUser");
            });

            modelBuilder.Entity<States>(entity =>
            {
                entity.HasKey(e => e.StateId);

                entity.HasIndex(e => e.StateName)
                    .HasName("UQ__States__554763157179ADF4")
                    .IsUnique();

                entity.Property(e => e.CreatedAt).HasColumnType("datetime");

                entity.Property(e => e.CreatedBy)
                    .IsRequired()
                    .HasMaxLength(50);

                entity.Property(e => e.IsPublished)
                    .IsRequired()
                    .HasDefaultValueSql("((1))");

                entity.Property(e => e.StateName)
                    .IsRequired()
                    .HasMaxLength(50);

                entity.Property(e => e.UpdatedAt).HasColumnType("datetime");

                entity.Property(e => e.UpdatedBy)
                    .IsRequired()
                    .HasMaxLength(50);
            });

            modelBuilder.Entity<Urgency>(entity =>
            {
                entity.HasIndex(e => new { e.PostId, e.UserId })
                    .HasName("UK_UrgencyUser")
                    .IsUnique();

                entity.Property(e => e.CreatedAt).HasColumnType("datetime");

                entity.Property(e => e.CreatedBy)
                    .IsRequired()
                    .HasMaxLength(50);

                entity.Property(e => e.IsPublished)
                    .IsRequired()
                    .HasDefaultValueSql("((1))");

                entity.Property(e => e.UpdatedAt).HasColumnType("datetime");

                entity.Property(e => e.UpdatedBy)
                    .IsRequired()
                    .HasMaxLength(50);

                entity.HasOne(d => d.Post)
                    .WithMany(p => p.Urgency)
                    .HasForeignKey(d => d.PostId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_UrgentPost");

                entity.HasOne(d => d.User)
                    .WithMany(p => p.Urgency)
                    .HasForeignKey(d => d.UserId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_UrgentUser");
            });

            modelBuilder.Entity<UserData>(entity =>
            {
                entity.HasKey(e => e.UserId)
                    .HasName("PK__UserData__1788CC4CE29543D8");

                entity.HasIndex(e => e.EmailAddress)
                    .HasName("UQ__UserData__49A1474010D2B3FA")
                    .IsUnique();

                entity.HasIndex(e => e.UserName)
                    .HasName("UQ__UserData__C9F284564FFC41D1")
                    .IsUnique();

                entity.HasIndex(e => e.Users)
                    .HasName("UQ__UserData__64B85EBE08A73687")
                    .IsUnique();

                entity.Property(e => e.CreatedAt).HasColumnType("datetime");

                entity.Property(e => e.CreatedBy)
                    .IsRequired()
                    .HasMaxLength(50);

                entity.Property(e => e.EmailAddress)
                    .IsRequired()
                    .HasMaxLength(50);

                entity.Property(e => e.FirstName)
                    .IsRequired()
                    .HasMaxLength(50);

                entity.Property(e => e.Gender)
                    .IsRequired()
                    .HasMaxLength(10);

                entity.Property(e => e.IsPublished)
                    .IsRequired()
                    .HasDefaultValueSql("((1))");

                entity.Property(e => e.LastName)
                    .IsRequired()
                    .HasMaxLength(50);

                entity.Property(e => e.MobileNo)
                    .IsRequired()
                    .HasMaxLength(50);

                entity.Property(e => e.UpdatedAt).HasColumnType("datetime");

                entity.Property(e => e.UpdatedBy)
                    .IsRequired()
                    .HasMaxLength(50);

                entity.Property(e => e.UserDescription).HasMaxLength(500);

                entity.Property(e => e.UserName)
                    .IsRequired()
                    .HasMaxLength(50);

                entity.HasOne(d => d.City)
                    .WithMany(p => p.UserData)
                    .HasForeignKey(d => d.CityId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_UserCity");

                entity.HasOne(d => d.Pincode)
                    .WithMany(p => p.UserData)
                    .HasForeignKey(d => d.PincodeId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_UserPin");

                entity.HasOne(d => d.State)
                    .WithMany(p => p.UserData)
                    .HasForeignKey(d => d.StateId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_UserState");

                entity.HasOne(d => d.UsersNavigation)
                    .WithOne(p => p.UserData)
                    .HasForeignKey<UserData>(d => d.Users)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Users");
            });

            modelBuilder.Entity<Users>(entity =>
            {
                entity.HasKey(e => e.UserId);

                entity.HasIndex(e => e.EmailAddress)
                    .HasName("UQ__Users__49A147408C653318")
                    .IsUnique();

                entity.HasIndex(e => e.PasswordHash)
                    .HasName("UQ__Users__D60E46A2A99E5F22")
                    .IsUnique();

                entity.HasIndex(e => e.UserName)
                    .HasName("UQ__Users__C9F284569B9B30E7")
                    .IsUnique();

                entity.Property(e => e.CreatedAt).HasColumnType("datetime");

                entity.Property(e => e.CreatedBy)
                    .IsRequired()
                    .HasMaxLength(50);

                entity.Property(e => e.EmailAddress)
                    .IsRequired()
                    .HasMaxLength(50);

                entity.Property(e => e.IsPublished)
                    .IsRequired()
                    .HasDefaultValueSql("((1))");

                entity.Property(e => e.MobileNo)
                    .IsRequired()
                    .HasMaxLength(50);

                entity.Property(e => e.OtpCreatedAt).HasColumnType("datetime");

                entity.Property(e => e.PasswordHash)
                    .IsRequired()
                    .HasMaxLength(100);

                entity.Property(e => e.UpdatedAt).HasColumnType("datetime");

                entity.Property(e => e.UpdatedBy)
                    .IsRequired()
                    .HasMaxLength(50);

                entity.Property(e => e.UserName)
                    .IsRequired()
                    .HasMaxLength(50);
            });

            modelBuilder.Entity<Volunteer>(entity =>
            {
                entity.Property(e => e.CreatedAt).HasColumnType("datetime");

                entity.Property(e => e.CreatedBy)
                    .IsRequired()
                    .HasMaxLength(50);

                entity.Property(e => e.IsPublished)
                    .IsRequired()
                    .HasDefaultValueSql("((1))");

                entity.Property(e => e.UpdatedAt).HasColumnType("datetime");

                entity.Property(e => e.UpdatedBy)
                    .IsRequired()
                    .HasMaxLength(50);

                entity.HasOne(d => d.Organisation)
                    .WithMany(p => p.Volunteer)
                    .HasForeignKey(d => d.OrganisationId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_VolunteerOrg");

                entity.HasOne(d => d.VolunteerUser)
                    .WithMany(p => p.Volunteer)
                    .HasForeignKey(d => d.VolunteerUserId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Volunteer");
            });

            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}
