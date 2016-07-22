/******************************************************************************
 * Copyright (c) 2016 Sergey Alexandrov
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to
 * deal in the Software without restriction, including without limitation the
 * rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
 * sell copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 ******************************************************************************/

#pragma once

#include <memory>
#include <string>
#include <stdexcept>

#include <boost/exception/info.hpp>
#include <boost/exception/exception.hpp>

#include <opencv2/core/core.hpp>

namespace grabbers {

class GrabberException : public boost::exception, public std::runtime_error {
 public:
  GrabberException(const std::string& message) : std::runtime_error(message) {}
  using ErrorInfo = boost::error_info<struct tag_error_info, std::string>;
};

class Grabber {
 public:
  using Ptr = std::shared_ptr<Grabber>;

  virtual ~Grabber();

  virtual bool hasMoreFrames() const = 0;

  virtual bool grabFrame(cv::OutputArray color) = 0;

  virtual void setAutoWhiteBalanceEnabled(bool state = true) = 0;

  virtual void setAutoExposureEnabled(bool state = true) = 0;

  virtual void setExposure(int exposure) = 0;

  virtual int getExposure() const = 0;

  virtual std::pair<int, int> getExposureRange() const = 0;

  virtual std::string getSerialNumber() const = 0;
};

}  // namespace grabbers
