function test_result = sufficient_descent_angle(grad, s)

test_result= grad'*s/(norm(grad)*norm(s));

end