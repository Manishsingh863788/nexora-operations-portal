import jwt from 'jsonwebtoken';
import { config } from '../config';
import { Role } from '../types/enums';

export interface JwtPayload {
  userId: string;
  email: string;
  role: Role;
  name: string;
}

export function generateToken(payload: JwtPayload): string {
  return jwt.sign(payload, config.jwtSecret, {
    expiresIn: config.jwtExpiresIn,
  });
}

export function verifyToken(token: string): JwtPayload {
  return jwt.verify(token, config.jwtSecret) as JwtPayload;
}
