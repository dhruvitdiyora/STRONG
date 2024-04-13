import { ComponentFixture, TestBed } from '@angular/core/testing';

import { RequirementTypeComponent } from './requirement-type.component';

describe('RequirementTypeComponent', () => {
  let component: RequirementTypeComponent;
  let fixture: ComponentFixture<RequirementTypeComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ RequirementTypeComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(RequirementTypeComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
