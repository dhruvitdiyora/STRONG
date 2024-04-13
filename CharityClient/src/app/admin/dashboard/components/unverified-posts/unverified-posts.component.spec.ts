import { ComponentFixture, TestBed } from '@angular/core/testing';

import { UnverifiedPostsComponent } from './unverified-posts.component';

describe('UnverifiedPostsComponent', () => {
  let component: UnverifiedPostsComponent;
  let fixture: ComponentFixture<UnverifiedPostsComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ UnverifiedPostsComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(UnverifiedPostsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
