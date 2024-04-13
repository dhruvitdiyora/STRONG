using System;
using CharityAPI.DTOs;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;

// Code scaffolded by EF Core assumes nullable reference types (NRTs) are not used or disabled.
// If you have enabled NRTs for your project, then un-comment the following line:
// #nullable disable

namespace CharityAPI.Models
{
    public partial class CharityAPIContext : DbContext
    {
        public CharityAPIContext()
        {
        }

        public CharityAPIContext(DbContextOptions<CharityAPIContext> options)
            : base(options)
        {
        }

        public virtual DbSet<Admins> Admins { get; set; }
        public virtual DbSet<Bookmark> Bookmark { get; set; }
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
        public virtual DbSet<PostDTO> PostDTOs { get; set; }

        public virtual DbSet<WebApiExceptionLog> WebApiExceptionLog { get; set; }
        public virtual DbSet<WebApiRequestLog> WebApiRequestLog { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<PostDTO>().HasNoKey().ToView(null);
            modelBuilder.Entity<Admins>(entity =>
            {
                entity.HasKey(e => e.AdminId);

                entity.HasIndex(e => e.EmailAddress)
                    .HasName("UQ__Admins__49A14740E02664AE")
                    .IsUnique();

                entity.HasIndex(e => e.UserName)
                    .HasName("UQ__Admins__C9F28456DC0F6680")
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

            modelBuilder.Entity<Bookmark>(entity =>
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

                entity.HasOne(d => d.Post)
                    .WithMany(p => p.Bookmark)
                    .HasForeignKey(d => d.PostId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_BookmarkPostId");

                entity.HasOne(d => d.User)
                    .WithMany(p => p.Bookmark)
                    .HasForeignKey(d => d.UserId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_BookmarkUserId");
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
                entity.HasIndex(e => e.OrganisationUserName)
                    .HasName("UK_OrgUserName")
                    .IsUnique();

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
                    .HasName("UQ__Organisa__49A14740A8D50C8C")
                    .IsUnique();

                entity.HasIndex(e => e.UserName)
                    .HasName("UQ__Organisa__C9F28456FBF64E5F")
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

                entity.Property(e => e.ImageUrl1).HasColumnName("ImageURL1");

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
                    .HasName("UQ__States__554763159872C9FA")
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
                    .HasName("PK__UserData__1788CC4C28CF7F2D");

                entity.HasIndex(e => e.EmailAddress)
                    .HasName("UQ__UserData__49A1474084721698")
                    .IsUnique();

                entity.HasIndex(e => e.UserName)
                    .HasName("UQ__UserData__C9F28456FE30D555")
                    .IsUnique();

                entity.HasIndex(e => e.Users)
                    .HasName("UQ__UserData__64B85EBEDACC43DB")
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
                    .HasName("UQ__Users__49A14740CAE312A9")
                    .IsUnique();

                entity.HasIndex(e => e.PasswordHash)
                    .HasName("UQ__Users__D60E46A216E418D0")
                    .IsUnique();

                entity.HasIndex(e => e.UserName)
                    .HasName("UQ__Users__C9F28456370DF103")
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

            modelBuilder.Entity<WebApiExceptionLog>(entity =>
            {
                entity.HasKey(e => e.LogId)
                    .HasName("PK__WebApiEx__5E548648741E97DB");

                entity.Property(e => e.CreatedOn).HasColumnType("datetime");

                entity.Property(e => e.IpAddress).HasMaxLength(50);

                entity.Property(e => e.Message).HasColumnType("ntext");

                entity.Property(e => e.StackTrace).HasColumnType("ntext");
            });

            modelBuilder.Entity<WebApiRequestLog>(entity =>
            {
                entity.HasKey(e => e.LogId)
                    .HasName("PK__WebApiRe__5E54864822104AD2");

                entity.Property(e => e.ActionName).HasMaxLength(100);

                entity.Property(e => e.ControllerName).HasMaxLength(300);

                entity.Property(e => e.CreatedBy).HasMaxLength(100);

                entity.Property(e => e.IpAddress).HasMaxLength(50);

                entity.Property(e => e.LogDescription).HasColumnType("ntext");

                entity.Property(e => e.RequestUri).HasMaxLength(500);
            });

            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}
