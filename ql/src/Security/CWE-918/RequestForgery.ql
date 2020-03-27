/**
 * @name Uncontrolled data used in network request
 * @description Sending network requests with user-controlled data allows for request forgery attacks.
 * @kind path-problem
 * @problem.severity error
 * @precision high
 * @id go/request-forgery
 * @tags security
 *       external/cwe/cwe-918
 */

import go
import semmle.go.security.RequestForgery::RequestForgery
import DataFlow::PathGraph

from Configuration cfg, DataFlow::PathNode source, DataFlow::PathNode sink, DataFlow::Node request
where
  cfg.hasFlowPath(source, sink) and
  request = sink.getNode().(Sink).getARequest()
select request, source, sink, "The $@ of this request depends on $@.", sink.getNode(),
  sink.getNode().(Sink).getKind(), source, "a user-provided value"
