import {
  Column,
  Entity,
  PrimaryGeneratedColumn,
  UpdateDateColumn
} from "typeorm";

@Entity()
export class Currency {
  @PrimaryGeneratedColumn()
  id: number;

  @Column()
  currency: string;

  @Column()
  exchangeRate: number;

  @UpdateDateColumn()
  exchangeRateSyncDate: Date;

  @Column({ default: 0 })
  main: boolean;
}