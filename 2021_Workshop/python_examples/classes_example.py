# @Author: Ilija Medan
# @Date: October 28th, 2021
# @Filename: classes_example.py
# @License: BSD 3-Clause
# @Copyright: Ilija Medan

import math


class KinematicEquations(object):
    """
    class to provide the kinematic equations for an object
    with some some acceleration and initial velocity

    Parameters
    ----------
    vi: float
        Initial velocity of object ib m/s

    a: float
        Acceleration of object in m/s^2
    """
    def __init__(self, vi, a):
        self.vi = vi
        self.a = a

    def distance_w_time(self, t):
        """
        Find distance in m traveled after time
        t in seconds

        Parameters
        ----------
        t: float
            Time in seconds

        Returns
        -------
        d: float
            Distance in m
        """
        d = self.vi * t + 0.5 * self.a * t**2
        return d

    def final_v_w_distance(self, d):
        """
        Find the final velocity in m/s after some
        distance d in m

        Parameters
        ----------
        d: float
            Distance in m

        Returns
        -------
        vf: float
            Final velocity in m/s
        """
        vf = math.sqrt(self.vi**2 + 2 * self.a * d)
        return vf

    def final_v_w_time(self, t):
        """
        Find the final velocity in m/s after some
        time t in sec

        Parameters
        ----------
        t: float
            Time in seconds

        Returns
        -------
        vf: float
            Final velocity in m/s
        """
        vf = self.vi + self.a * t
        return vf


class FreeFallTime(KinematicEquations):
    """
    Estimate the time for an object to fall some distance
    in some acceleration and with some initial velocity

    Parameters
    ----------
    vi: float
        Initial velocity of object ib m/s

    a: float
        Acceleration of object in m/s^2

    d: float
        Distance in m
    """
    def __init__(self, vi, a, d):
        self.vi = vi
        self.a = a
        self.d = d

    def find_time(self, dt):
        """
        Estimate the time for the object to fall

        Parameters
        ----------
        dt: float
            Time interval in seconds to iterate
            over

        Returns
        --------
        t: float
            Estimated time for object to fall
            in seconds
        """
        t = 0
        d_curr = self.distance_w_time(t)
        while d_curr >= self.d:
            t += dt
            d_curr = self.distance_w_time(t)
        return t
