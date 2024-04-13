import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ProfilepostComponent } from './profilepost.component';

describe('ProfilepostComponent', () => {
  let component: ProfilepostComponent;
  let fixture: ComponentFixture<ProfilepostComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ ProfilepostComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(ProfilepostComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
