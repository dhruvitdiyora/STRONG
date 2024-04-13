import { ComponentFixture, TestBed } from '@angular/core/testing';

import { VerifiedPostsComponent } from './verified-posts.component';

describe('VerifiedPostsComponent', () => {
  let component: VerifiedPostsComponent;
  let fixture: ComponentFixture<VerifiedPostsComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ VerifiedPostsComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(VerifiedPostsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
