import { ComponentFixture, TestBed } from '@angular/core/testing';

import { UnverifiedOrgsComponent } from './unverified-orgs.component';

describe('UnverifiedOrgsComponent', () => {
  let component: UnverifiedOrgsComponent;
  let fixture: ComponentFixture<UnverifiedOrgsComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ UnverifiedOrgsComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(UnverifiedOrgsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
